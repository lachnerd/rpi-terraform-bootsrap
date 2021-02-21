locals{ 
  ssh_timeout = "30s"
  script_path = "${path.module}/scripts" 
}

resource "null_resource" "updates" {
  provisioner "remote-exec" {
    script = "${local.script_path}/update.sh"
    connection {
      type = "ssh"
      user = "root"
      private_key = var.ssh_private_key
      host = var.primary_ip
      timeout = local.ssh_timeout
    }
  }
}

resource "null_resource" "ssh" {
  depends_on = [null_resource.updates]
  provisioner "remote-exec" {
    script = "${local.script_path}/ssh.sh"
    connection {
      type = "ssh"
      user = "root"
      private_key = var.ssh_private_key
      host = var.primary_ip
      timeout = local.ssh_timeout
    }
  }
}

resource "null_resource" "fail2ban" {
  depends_on = [null_resource.ssh]
  provisioner "remote-exec" {
    script = "${local.script_path}/fail2ban.sh"
    connection {
      type = "ssh"
      user = "root"
      port = "2222"
      private_key = var.ssh_private_key
      host = var.primary_ip
      timeout = local.ssh_timeout
    }
  }
}