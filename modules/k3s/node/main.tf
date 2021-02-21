locals{ 
  ssh_timeout = "30s"
  template_path = "${path.module}/templates"
  //template for initializing k3s master
  k3s_init = templatefile("${local.template_path}/k3s_init.sh", { k3s_token = var.k3s_token, k3s_channel = var.k3s_channel, k3s_master_ip = var.k3s_master_ip}) 
}

resource "null_resource" "k3s-install" {
  connection {
      type = "ssh"
      user = "root"
      port = "2222"
      private_key = var.ssh_private_key
      host = var.primary_ip
      timeout = local.ssh_timeout
    }  
  
  //template content (local.k3s_init) got written to remote file /tmp/k3s_init.sh
  provisioner "remote-exec" {
  inline = [
      "--- echo 'render k3s worker script' ---",
      "tee /tmp/k3s_init.sh <<EOF",
      local.k3s_init,
      "EOF",
      "chmod +x /tmp/k3s_init.sh",
      "--- echo 'install k3s master' ---",
      "/tmp/k3s_init.sh"
    ]
  }
}
