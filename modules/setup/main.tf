/******************************************************************************************************
 * add user
 * adds a new user
 ******************************************************************************************************/

resource "random_string" "password" {
  length = 24
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}

resource "null_resource" "target_group_depends_on" {
  triggers = {
    # The reference to the variable here creates an implicit
    # dependency on the variable.
    # content is an output variable from a source module
    dependency = "${var.target_group_depends_on}"
  }
}

resource "null_resource" "del_pi" {
  depends_on = ["null_resource.target_group_depends_on"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'delete pi user'",
      "echo '-------------------------------------'",     
      "echo 'list of all local users'",
      "cut -d: -f1 /etc/passwd", 
      "sudo userdel -r pi",
      "echo 'list of all local users after delete'",
      "cut -d: -f1 /etc/passwd", 
      "echo '-------------------------------------'"
    ]
  }
}

resource "null_resource" "disable_swap" {
  depends_on = ["null_resource.del_pi"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'disable swap'",
      "echo '-------------------------------------'",     
      "free -h",
      "sudo dphys-swapfile swapoff", 
      "sudo dphys-swapfile uninstall",
      "echo 'disable swap service'",
      "sudo systemctl disable dphys-swapfile",
      "echo 'new swap status'",
      "free -h",
      "echo '-------------------------------------'",
      "echo 'disable swap'",
      "echo '-------------------------------------'",
    ]
  }
}

resource "null_resource" "timezone" {
  depends_on = ["null_resource.disable_swap"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'timezone'",
      "echo '-------------------------------------'",     
      "echo 'current time zone'",
      "cat /etc/timezone",
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true",
      "echo 'current time zone'",
      "timedatectl",
      "echo '-------------------------------------'",
      "echo 'timezone'",
      "echo '-------------------------------------'",
    ]
  }
}


resource "null_resource" "hostname" {
  depends_on = ["null_resource.timezone"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'hostname'",
      "echo '-------------------------------------'",     
      "echo 'current hostname'",
      "getent hosts",
      "sudo hostnamectl set-hostname ${var.hostname}",
      "sudo sed -i 's/raspberrypi/${var.hostname}/g' /etc/hosts",
      "echo 'current hostname'",
      "getent hosts",
      "hostname",
      "echo '-------------------------------------'",
      "echo 'hostname'",
      "echo '-------------------------------------'",
    ]
  }
}

/*
resource "random_string" "dependency_dummy" {
  depends_on = ["null_resource.tools"]
  length = 30
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}
*/
