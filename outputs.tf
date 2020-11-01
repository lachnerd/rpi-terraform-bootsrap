output "private_key" {
  description="tls/ssh private key"
  value = "${module.ssh.private_key}"
}

output "public_key" {
  description="tls/ssh public key"
  value = "${module.ssh.public_key}"
}

output "user" {
  description="new user"
  value = "${var.user}"
}

output "password" {
  description="password from new sudo user"
  value = "${module.adduser.password}"
}