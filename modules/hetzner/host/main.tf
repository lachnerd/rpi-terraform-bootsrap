resource "hcloud_ssh_key" "default" {
  name = "ssh-${random_pet.servername.id}-${var.index}"  
  public_key = var.ssh_public_key
}

#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet
resource "random_pet" "servername" {
  length = 3
  prefix = var.name
  separator = "-"
}

resource "hcloud_server" "node" {
  //if name is null a random pet name is used
  #name = var.name != null ? var.name : random_pet.servername.id
  name = random_pet.servername.id
  image = var.image
  server_type = var.server_type
  location = var.location
  backups = var.backups
  ssh_keys = [hcloud_ssh_key.default.id]
  //keep_disk - if true, do not upgrade the disk. This allows downgrading the server type later.
  keep_disk   = true
  #https://docs.hetzner.cloud/#labels
  #labels = { env="test",tld="show" }
}