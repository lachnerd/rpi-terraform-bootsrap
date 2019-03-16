# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html
locals{
  host_script_path = "/tmp/scripts"
  host_template_path = "/tmp/templates"
  ssh_timeout = "10s"
  default_sleep = "1s"
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
      "mkdir -vp ${local.host_script_path}", 
      "mkdir -vp ${local.host_template_path}",
    ]
  }
}

/******************************************************************************************************
 * COPY
 ******************************************************************************************************/

resource "null_resource" "copy" {  
  depends_on = ["null_resource.init"]
  connection {
    type = "ssh"    
    user = "${var.initial_user}"
    password = "${var.initial_password}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/"
    destination = "${local.host_script_path}"
  }

  provisioner "file" {
    source      = "${path.module}/templates/"
    destination = "${local.host_template_path}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'copy ressources to host'",   
    ]
  }
  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "echo 'deleting scripts and templates'",
      "rm -fr ${local.host_script_path}",   
      "rm -fr ${local.host_template_path}",    
    ]
  }
}

/******************************************************************************************************
 * ADDUSER
 ******************************************************************************************************/
resource "random_string" "password" {
  length = 24
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}

resource "null_resource" "adduser" {
  depends_on = ["null_resource.copy"]

  connection {
    type = "ssh"    
    user = "${var.initial_user}"
    password = "${var.initial_password}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ${local.host_script_path}/init_adduser.sh",
      "${local.host_script_path}/init_adduser.sh ${var.new_user} ${random_string.password.result} ${var.initial_user}",
    ]
  }

  provisioner "remote-exec" {
    when = "destroy" 
    inline = [
      "sudo chmod +x ${local.host_script_path}/destroy_adduser.sh",
      "${local.host_script_path}/destroy_adduser.sh ${var.initial_user} ${var.initial_password} ${var.new_user}",
    ]
  }
}
/******************************************************************************************************
 * SSH COPY ID
 ******************************************************************************************************/
 # connects as new user & copies the public key to its /home/pi/.ssh/authorized_keys
resource "null_resource" "ssh-copy-id" {
  depends_on = ["null_resource.adduser"]
  connection {
    type = "ssh"    
    user = "${var.new_user}"
    password = "${random_string.password.result}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "file" {
    source      = "${var.public_key_path}"
    destination = "/tmp/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      #create .ssh folder in /home/pi
      "mkdir -vp ~/.ssh",
      #write public key to /home/pi/.ssh/authorized_keys
      "cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys", 
      #delete tmp file
      "sudo rm -fv /tmp/id_rsa.pub",
    ]
  }
}

/******************************************************************************************************
 * HOSTNAME
 ******************************************************************************************************/

resource "null_resource" "hostname" {
  depends_on = ["null_resource.ssh-copy-id"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.new_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ${local.host_script_path}/init_hostname.sh",
      "sudo ${local.host_script_path}/init_hostname.sh ${var.hostname}",    
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "sudo chmod +x ${local.host_script_path}/destroy_hostname.sh",
      "sudo ${local.host_script_path}/destroy_hostname.sh",    
    ]
  }
}

/******************************************************************************************************
 * DISABLESWAP
 ******************************************************************************************************/

resource "null_resource" "disableswap" {
  depends_on = ["null_resource.ssh-copy-id"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.new_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ${local.host_script_path}/init_disableswap.sh",
      "sudo ${local.host_script_path}/init_disableswap.sh",    
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "sudo chmod +x ${local.host_script_path}/destroy_disableswap.sh",
      "sudo ${local.host_script_path}/destroy_disableswap.sh",    
    ]
  }
}

/******************************************************************************************************
 * TIMEZONE
 ******************************************************************************************************/

resource "null_resource" "timezone" {
  depends_on = ["null_resource.ssh-copy-id"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.new_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ${local.host_script_path}/init_timezone.sh",
      "sudo ${local.host_script_path}/init_timezone.sh ${var.timezone}",    
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "sudo chmod +x ${local.host_script_path}/destroy_timezone.sh",
      "sudo ${local.host_script_path}/destroy_timezone.sh",    
    ]
  }
}


/******************************************************************************************************
 * UPDATE
 ******************************************************************************************************/

resource "null_resource" "update" {
  depends_on = ["null_resource.timezone"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.new_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ${local.host_script_path}/init_update.sh",
      "sudo ${local.host_script_path}/init_update.sh",    
    ]
  }
}