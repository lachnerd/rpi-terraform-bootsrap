# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html
# tested with 2020-02-13-raspbian-buster-lite.img

# Definition of provider mit versions to avoid unwanted surprises ;-)
provider "tls" {
    version = "~> 2.2" 
}

provider "local" {
    version = "~> 1.4" 
}

provider "null" {
    version = "~> 2.1.2" 
}

provider "random" {
    version = "~> 2.3" 
}

locals{
    ssh_folder = "${path.module}/output/.ssh"
}

module "ssh" {
  source = ".//modules/ssh"
  ssh_folder = "${local.ssh_folder}"
}

module "adduser" {
  source = ".//modules/adduser"
  target_group_depends_on = "${module.ssh.public_key}"
  user = "${var.user}"
  initial_user = "${var.initial_user}"
  initial_password = "${var.initial_password}"
  ip_adress = "${var.ip_adress}"
}

module "sshcopy" {
  source = ".//modules/sshcopy"
  target_group_depends_on = "${module.adduser.password}"
  user = "${var.user}"
  password = "${module.adduser.password}"
  ip_adress = "${var.ip_adress}"
  ssh_public_key = "${module.ssh.public_key_path}"
}

module "updates" {
  source = ".//modules/updates"
  target_group_depends_on = "${module.sshcopy.dependency_dummy}"
  user = "${var.user}"
  private_key = "${module.ssh.private_key}"
  ip_adress = "${var.ip_adress}"
}

module "setup" {
  source = ".//modules/setup"
  target_group_depends_on = "${module.updates.dependency_dummy}"
  user = "${var.user}"
  private_key = "${module.ssh.private_key}"
  ip_adress = "${var.ip_adress}"
  timezone = "${var.timezone}"
  hostname = "${var.hostname}"
  email = "${var.email}"
}