locals {
  keyfile = "id_rsa"
}

resource "tls_private_key" "rsa_private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#creates a local file id_rsa containing the actual private key in PEM Format
#cannot be used with RDP Manager on windows must be converted to ppk format
resource "local_file" "private_key" {
    content = tls_private_key.rsa_private.private_key_pem
    filename = "${var.ssh_folder}/${local.keyfile}"
}

#creates a local file id_rsa.pub containing the actual public key in openssh format
resource "local_file" "public_key" {
    content = tls_private_key.rsa_private.public_key_openssh
    filename = "${var.ssh_folder}/${local.keyfile}.pub"
}

#creates a windows compatible *.ppk format file
resource "null_resource" "puttygen_ppk" {
  depends_on = [local_file.private_key,local_file.public_key]
  
  provisioner "local-exec" {
    working_dir = var.ssh_folder
    command = "puttygen ${local.keyfile} -o ${local.keyfile}.ppk -O private"
  }
}
