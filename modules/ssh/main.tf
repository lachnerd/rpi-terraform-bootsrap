# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html
locals{
  host_script_path = "/opt/terraform/scripts"
  host_template_path = "/opt/terraform/templates"
  ssh_timeout = "10s"
  default_sleep = "1s"
  ssh_private_key = "${path.module}/.ssh/id_rsa"
  ssh_public_key = "${path.module}/.ssh/id_rsa.pub"
}

/******************************************************************************************************
 * SSH KEY
 ******************************************************************************************************/
#generates a RSA private key for authentication
resource "tls_private_key" "rsa_private" {
  //depends_on = ["null_resource.init"]
  algorithm = "RSA"
  rsa_bits  = 4096
}

#creates a local file id_rsa containing the actual private key in PEM Format
resource "local_file" "private_key" {
    count = 1
    content = "${tls_private_key.rsa_private.private_key_pem}"
    filename = "${local.ssh_private_key}"
}

#creates a local file id_rsa.pub containing the actual public key in openssh format
resource "local_file" "public_key" {
    count = 1
    content = "${tls_private_key.rsa_private.public_key_openssh}"
    filename = "${local.ssh_public_key}"
}

/******************************************************************************************************
 * INIT
 ******************************************************************************************************/

resource "null_resource" "init" {
  connection {
    type = "ssh"    
    user = "${var.initial_user}"
    password = "${var.initial_password}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'creating script folders'",
      "sudo mkdir -vp ${local.host_script_path}", 
      "sudo mkdir -vp ${local.host_template_path}",
      "sudo chmod -R 777 /opt/terraform/",
    ]
  }
}