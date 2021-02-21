locals{ 
  ssh_timeout = "30s"
}

resource "null_resource" "ufw" {
  connection {
    type = "ssh"
    user = "root"
    port = "2222"
    private_key = var.ssh_private_key
    host = var.primary_ip
    timeout = local.ssh_timeout
  }

  # install ufw
  provisioner "remote-exec" {
    inline = [
      "echo 'install ufw'",
      "apt install ufw",
      "ufw status numbered verbose"
    ]
  }

  #add standard rules
  provisioner "remote-exec" {
    inline = [
      "echo 'add standard ufw rules'",
      "ufw default deny incoming",
      "ufw default allow outgoing",
      #open ssh on custum port
      "ufw allow 2222",
      #"ufw allow from <IP or CIDR> proto udp to any port <PORT>",
      #HTTP Verkehr erlauben 
      "ufw allow proto tcp from any to any port 443",
      "ufw allow proto tcp from any to any port 80"
    ]
  }

  #enable ufw
  provisioner "remote-exec" {
    inline = [
      "echo 'enable ufw'",
      #enabel ufw without interaction
      "yes | sudo ufw enable",
      "ufw status numbered verbose"
    ]
  }
}