locals{ 
  ssh_timeout = "30s"
  script_path = "${path.module}/scripts" 
}

resource "null_resource" "docker-install" {
  connection {
      type = "ssh"
      user = "root"
      port = "2222"
      private_key = var.ssh_private_key
      host = var.primary_ip
      timeout = local.ssh_timeout
    }

  #just for copying bash-script to host
  provisioner "file" {
    source      = "${local.script_path}/docker-install.sh"
    destination = "/tmp/docker-install.sh"
  }

  provisioner "remote-exec" {
  #script = "${local.script_path}/docker-install.sh"
  inline = [
      "--- echo 'install docker-ce' ---",
      "chmod +x /tmp/docker-install.sh",
      "/tmp/docker-install.sh ${var.docker_ce_version} ${var.docker_dns_1} ${var.docker_dns_2} ${var.docker_dns_3} ${var.docker_dns_4}",      
    ]
  }

  provisioner "remote-exec" {
    inline = [  
      "--- echo 'docker - hello world' ---",
      "echo 'try docker hello-world'",
      "docker pull hello-world:latest",
      "docker run --rm hello-world",
    ]
  }

  provisioner "remote-exec" {
    script = "${local.script_path}/maintenance.sh"
  }
}