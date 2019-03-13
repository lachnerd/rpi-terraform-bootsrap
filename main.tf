# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html
/*
module "rsakey" {
  source = "modules/rsakey"
  hostname = "${var.hostname}"
  ip_adress = "${var.ip_adress}"
  sshkeyfile = "sshkey-${var.hostname}"
}*/

module "hostname" {
  source = "modules/hostname"
  hostname = "${var.hostname}"
  private_key_path = "${var.private_key_path}"
  ip_adress = "${var.ip_adress}"
}

module "timezone" {
  source = "modules/timezone"
  timezone = "${var.timezone}"
  private_key_path = "${var.private_key_path}"
  ip_adress = "${var.ip_adress}"
  dependency = "${module.hostname.dependency_output}"
}

module "disableswap" {
  source = "modules/disableswap"
  private_key_path = "${var.private_key_path}"
  ip_adress = "${var.ip_adress}"
  dependency = "${module.timezone.dependency_output}"
}

module "update" {
  source = "modules/update"
  private_key_path = "${var.private_key_path}"
  ip_adress = "${var.ip_adress}"
  dependency = "${module.disableswap.dependency_output}"
}