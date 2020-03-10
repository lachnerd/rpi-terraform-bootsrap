# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html

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
  ssh_folder = "${path.module}/.ssh"
}

module "ssh" {
  source = ".//modules/ssh"
  ip_adress = "${var.ip_adress}"
  initial_user = "${var.initial_user}"
  initial_password = "${var.initial_password}"
  ssh_private_key = "${local.ssh_folder}/id_rsa"
  ssh_public_key = "${local.ssh_folder}/id_rsa.pub"
}