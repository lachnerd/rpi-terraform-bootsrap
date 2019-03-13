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
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

    provisioner "remote-exec" {
    inline = [
      "echo 'creating script folders'",
      "mkdir ${local.host_script_path}", 
      "mkdir ${local.host_template_path}",  
    ]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
/******************************************************************************************************
 * COPY
 ******************************************************************************************************/

resource "null_resource" "copy" {  
  depends_on = ["null_resource.init"]
  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
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
      "rm -r ${local.host_script_path}",   
      "rm -r ${local.host_template_path}",    
    ]
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
/******************************************************************************************************
 * UPDATE
 ******************************************************************************************************/
resource "null_resource" "update" {
  depends_on = ["null_resource.copy"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.host_script_path}/init_update.sh",
      "${local.host_script_path}/init_update.sh ${var.timezone}",    
    ]
  }
}
/******************************************************************************************************
 * HOSTNAME
 ******************************************************************************************************/
resource "null_resource" "hostname" {
  depends_on = ["null_resource.update"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.host_script_path}/init_hostname.sh",
      "${local.host_script_path}/init_hostname.sh ${var.hostname}",    
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "chmod +x ${local.host_script_path}/destroy_hostname.sh",
      "${local.host_script_path}/destroy_hostname.sh",    
    ]
  }
}

/******************************************************************************************************
 * DISABLESWAP
 ******************************************************************************************************/
resource "null_resource" "disableswap" {
  depends_on = ["null_resource.update"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.host_script_path}/init_disableswap.sh",
      "${local.host_script_path}/init_disableswap.sh",    
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "chmod +x ${local.host_script_path}/destroy_disableswap.sh",
      "${local.host_script_path}/destroy_disableswap.sh",    
    ]
  }
}

/******************************************************************************************************
 * TIMEZONE
 ******************************************************************************************************/
resource "null_resource" "timezone" {
  depends_on = ["null_resource.update"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.host_script_path}/init_timezone.sh",
      "${local.host_script_path}/init_timezone.sh ${var.timezone}",    
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "chmod +x ${local.host_script_path}/destroy_timezone.sh",
      "${local.host_script_path}/destroy_timezone.sh",    
    ]
  }
}

/******************************************************************************************************
 * PASSWORD
 ******************************************************************************************************/
/*resource "random_string" "password" {
  length = 24
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}

resource "null_resource" "password" {
  depends_on = ["random_string.password"]

  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${var.initial_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo pi:${random_string.password.result} | /usr/sbin/chpasswd", 
    ]
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "echo pi:raspberry | /usr/sbin/chpasswd",  
    ]
  }
}*/