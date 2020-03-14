
locals{
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
    filename = "${var.ssh_private_key}"
}

#creates a local file id_rsa.pub containing the actual public key in openssh format
resource "local_file" "public_key" {
    count = 1
    content = "${tls_private_key.rsa_private.public_key_openssh}"
    filename = "${var.ssh_public_key}"
}

# creates windows compatible ppk file
resource "null_resource" "ppk_generate" {
  depends_on = ["local_file.private_key","local_file.public_key"]
  provisioner "local-exec" {
    #dirname gets folder from key File
    working_dir = dirname("${var.ssh_private_key}")
    command = "puttygen id_rsa -o id_rsa.ppk -O private"
  }
}