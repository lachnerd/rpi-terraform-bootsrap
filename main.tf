# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html
module "ssh" {
  source = ".//modules/ssh"
  ip_adress = "${var.ip_adress}"
  hostname = "${var.hostname}"
  initial_user = "${var.initial_user}"
  initial_password = "${var.initial_password}"
}