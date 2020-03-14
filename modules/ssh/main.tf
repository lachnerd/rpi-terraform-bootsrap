
locals{
    keyfilename = "id_rsa"
}

#generates a RSA private key for authentication
resource "tls_private_key" "rsa_private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#creates a local file id_rsa containing the actual private key in PEM Format
resource "local_file" "private_key" {
    count = 1
    content = "${tls_private_key.rsa_private.private_key_pem}"
    filename = "${var.ssh_folder}/${local.keyfilename}"
}

#creates a local file id_rsa.pub containing the actual public key in openssh format
resource "local_file" "public_key" {
    count = 1
    content = "${tls_private_key.rsa_private.public_key_openssh}"
    filename = "${var.ssh_folder}/${local.keyfilename}.pub"
}

# creates windows compatible ppk file
resource "null_resource" "puttygen_ppk" {
  depends_on = ["local_file.private_key","local_file.public_key"]
  provisioner "local-exec" {
    #dirname gets folder from key File
    working_dir = "${var.ssh_folder}"
    command = "puttygen ${local.keyfilename} -o ${local.keyfilename}.ppk -O private"
    #delete id_rsa.ppk on destroy
  }
  provisioner "local-exec" {
     when = "destroy"
     working_dir = "${var.ssh_folder}"
     command = "rm ${local.keyfilename}.ppk"
    }
}
