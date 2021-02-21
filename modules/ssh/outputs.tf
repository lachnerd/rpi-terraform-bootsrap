output "private_key" {
  value = try(tls_private_key.rsa_private.private_key_pem, {})
  description = "The private key data in PEM format"
}

output "private_key_file" {
  value = try("${var.ssh_folder}/${local.keyfile}", {})
  description = "The private key data file path"
}

output "public_key" {
  value = try(tls_private_key.rsa_private.public_key_pem, {})
  description = "The public key data in PEM format"
}

output "public_key_file" {
  value = try("${var.ssh_folder}/${local.keyfile}.pub", {})
  description = "The public key data file path"
}

output "public_key_openssh" {
  value = try(tls_private_key.rsa_private.public_key_openssh, {})
  description = "The public key data in OpenSSH format"
}

