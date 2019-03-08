//lokale Variablen um so gut wie möglich DRY zu folgen
locals{
  script_path = "${path.module}/scripts"
  tmp_path = "/tmp"
  timezone_init_script = "set_timezone.sh"
  timezone_destroy_script = "cleanup_timezone.sh"
  ssh_timeout = "10s"
  ssh_user = "pi"
  default_sleep = "1s"
}

resource "null_resource" "timezone" {
  connection {
    type = "ssh"
    private_key = "${file("${var.private_key_path}")}"
    user = "${local.ssh_user}"
    host = "${var.ip_adress}"
    timeout = "${local.ssh_timeout}"
  }
  
  #You cannot pass any arguments to scripts using the script or scripts arguments to this provisioner. 
  #If you want to specify arguments, upload the script with the file provisioner and then use inline to call it.


  #----------------------------------------------------------------
  # Hostname
  #----------------------------------------------------------------
  provisioner "file" {
    source      = "${local.script_path}/${local.timezone_init_script}"
    destination = "${local.tmp_path}/${local.timezone_init_script}"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep ${local.default_sleep}",
      "if [ ! -f ${local.tmp_path}/${local.timezone_init_script} ]; then echo '${local.tmp_path}/${local.timezone_init_script} not found!'; else echo '${local.tmp_path}/${local.timezone_init_script} found'; fi",
      #make script executable
      "chmod -v +x ${local.tmp_path}/${local.timezone_init_script}",
      #execute it
      "${local.tmp_path}/${local.timezone_init_script} ${var.timezone}",
    ]
  }

  provisioner "file" {
    when = "destroy"
    source      = "${local.script_path}/${local.timezone_destroy_script}"
    destination = "${local.tmp_path}/${local.timezone_destroy_script}"
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      "sleep ${local.default_sleep}",
      "if [ ! -f ${local.tmp_path}/${local.timezone_destroy_script} ]; then echo '${local.tmp_path}/${local.timezone_destroy_script} not found!'; else echo '${local.tmp_path}/${local.timezone_destroy_script} found'; fi",
      #make script executable
      "chmod +x ${local.tmp_path}/${local.timezone_destroy_script}",
      #execute it
      "${local.tmp_path}/${local.timezone_destroy_script}",    
    ]
  }

}
