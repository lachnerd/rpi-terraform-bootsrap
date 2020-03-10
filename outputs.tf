output "private_key" {
  value = "${module.ssh.private_key}" 
  description = "the private key data in PEM format"
}

output "public_key" {
  value = "${module.ssh.public_key}" 
  description = "the public key"
}