output "private_key" {
  value = "${tls_private_key.rsa_private.private_key_pem}" 
  description = "The private key data in PEM format"
}

output "public_key" {
  value = "${tls_private_key.rsa_private.public_key_pem }" 
  description = "The public key data in PEM format"
}

output "public_key_path" {
  value = "${var.ssh_folder}/${local.keyfilename}.pub" 
}