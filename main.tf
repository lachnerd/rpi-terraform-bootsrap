# TODO

provider "local" {
  version = "~> 1.4"
}

provider "null" {
  version = "~> 2.1"
}

provider "tls" {
  version = "~> 2.1"
}

locals {
  ssh_folder = "${path.module}/output/.ssh"
}

module "ssh" {
  source = ".//modules/ssh"
  ip_adress = "${var.ip_adress}"
  initial_user = "${var.initial_user}"
  initial_password = "${var.initial_password}"
  ssh_private_key = "${local.ssh_folder}/id_rsa"
  ssh_public_key = "${local.ssh_folder}/id_rsa.pub"
}