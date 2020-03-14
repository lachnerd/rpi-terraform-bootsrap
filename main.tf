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
  ssh_folder = "${local.ssh_folder}"
}