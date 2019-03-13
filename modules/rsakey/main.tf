//lokale Variablen um so gut wie möglich DRY zu folgen
locals{
  script_path = "${path.module}/scripts"
}

resource "null_resource" "rsakey" {
  provisioner "local-exec" {
    command = "ssh-keygen -b 4096 -C ${var.hostname} -t rsa -f ${local.sshkey_filename}"
  }
}
