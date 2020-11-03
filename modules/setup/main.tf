/******************************************************************************************************
 * add user
 * adds a new user
 ******************************************************************************************************/
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
      "echo 'delete pi user - start'",
      "echo '-------------------------------------'",     
      "echo 'list of all local users'",
      "cut -d: -f1 /etc/passwd", 
      "sudo userdel -r pi",
      "echo 'list of all local users after delete'",
      "cut -d: -f1 /etc/passwd", 
      "echo '-------------------------------------'",
      "echo 'delete pi user - end'",
      "echo '-------------------------------------'", 
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
      "echo 'disable swap - start'",
      "echo '-------------------------------------'",     
      "free -h",
      "sudo dphys-swapfile swapoff", 
      "sudo dphys-swapfile uninstall",
      "echo 'disable swap service'",
      "sudo systemctl disable dphys-swapfile",
      "echo 'new swap status'",
      "free -h",
      "echo '-------------------------------------'",
      "echo 'disable swap - end'",
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
      "echo 'timezone - start'",
      "echo '-------------------------------------'",     
      "echo 'current time zone'",
      "cat /etc/timezone",
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true",
      "echo 'current time zone'",
      "timedatectl",
      "echo '-------------------------------------'",
      "echo 'timezone - end'",
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
      "echo 'hostname - start'",
      "echo '-------------------------------------'",     
      "echo 'current hostname'",
      "getent hosts",
      "sudo hostnamectl set-hostname ${var.hostname}",
      "sudo sed -i 's/raspberrypi/${var.hostname}/g' /etc/hosts",
      "echo 'current hostname'",
      "getent hosts",
      "hostname",
      "echo '-------------------------------------'",
      "echo 'hostname - end'",
      "echo '-------------------------------------'",
    ]
  }
}

resource "null_resource" "auto_update" {
  depends_on = ["null_resource.hostname"]

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
      "echo 'auto_update - start'",
      "echo '-------------------------------------'",     
      "echo 'install cron-apt...'",
      "sudo apt-get install cron-apt -y",
      "sudo sed -i '$a MAILON='always'' /etc/cron-apt/config",
      "sudo sed -i '$a MAILTO='${var.email}'' /etc/cron-apt/config",
      "echo '-------------------------------------'",
      "echo 'auto_update - end'",
      "echo '-------------------------------------'",
    ]
  }
}

locals{
    reboot_required = "/opt/reboot_required.sh"
    reboot_required_log = "/var/log/reboot_required.log"
}

resource "null_resource" "auto_reboot" {
  depends_on = ["null_resource.auto_update"]

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
      "echo 'auto_reboot - start'",
      "echo '-------------------------------------'",     
      "echo 'reboot script schreiben...'",
      "sudo touch ${local.reboot_required}",
      "echo '#!/usr/bin/env bash' | sudo tee -a ${local.reboot_required}",
      "echo 'if test -f /var/run/reboot-required; then' | sudo tee -a ${local.reboot_required}",
      "echo 'echo 'date -u'' | sudo tee -a ${local.reboot_required}",
      "echo 'cat /var/run/reboot-required' | sudo tee -a ${local.reboot_required}",
      "echo 'echo 'Following Packages will be upgraded'' | sudo tee -a ${local.reboot_required}",
      "echo 'cat /var/run/reboot-required.pgks' | sudo tee -a ${local.reboot_required}",
      "echo 'echo 'The server restarts in 2 Minutes'' | sudo tee -a ${local.reboot_required}",
      "echo '/sbin/shutdown -r +2' | sudo tee -a ${local.reboot_required}",
      "echo 'fi' | sudo tee -a ${local.reboot_required}",
      "echo 'display content of ${local.reboot_required}:'",
      "sudo cat ${local.reboot_required}",
      "sudo chmod +x ${local.reboot_required}",
      "echo 'write cronjob'",
      "sudo touch ${local.reboot_required_log}",
      "crontab -l > file; echo '0 3 * * SUN ${local.reboot_required} >> ${local.reboot_required_log} 2>&1' >> file; crontab file",
      "echo '-------------------------------------'",
      "echo 'auto_reboot - end'",
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
