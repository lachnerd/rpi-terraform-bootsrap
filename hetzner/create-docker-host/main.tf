locals{
  ssh_folder = "${path.module}/output/.ssh"
}

provider "hcloud" {
  token = var.hcloud_token
}

module "ssh" {
  count = var.nodes
  source = "../../modules/ssh"
  ssh_folder = "${local.ssh_folder}/${count.index}/"
}

module "hetzner_host" {
  count = var.nodes  
  source = "../../modules/hetzner/host"
  index = count.index
  ssh_public_key = module.ssh[count.index].public_key_openssh
  api_token = var.hcloud_token
  name = var.server_host_name
  server_type = var.server_type
  backups = var.server_backup
}

module "host_init" {
  count = var.nodes
  source = "../../modules/host_init"
  ssh_private_key = module.ssh[count.index].private_key
  primary_ip = module.hetzner_host[count.index].host_ip
}

module "docker" {
  count = var.nodes
  source = "../../modules/docker"
  depends_on = [module.host_init]
  ssh_private_key = module.ssh[count.index].private_key
  primary_ip = module.hetzner_host[count.index].host_ip
  docker_ce_version = var.docker_ce_version
}

module "ufw" {
  count = var.nodes
  source = "../../modules/ufw"
  depends_on = [module.docker]
  ssh_private_key = module.ssh[count.index].private_key
  primary_ip = module.hetzner_host[count.index].host_ip
}