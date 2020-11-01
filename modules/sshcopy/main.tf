/******************************************************************************************************
 * add user
 * adds a new user
 ******************************************************************************************************/

resource "null_resource" "target_group_depends_on" {
  triggers = {
    # The reference to the variable here creates an implicit
    # dependency on the variable.
    # content is an output variable from a source module
    dependency = "${var.target_group_depends_on}"
  }
}

resource "null_resource" "ssh_copy" {
  depends_on = ["null_resource.target_group_depends_on"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    password = "${var.password}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "file" {
    source      = "${var.ssh_public_key}"
    destination = "/tmp/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'copy ssh public key...'",
      "echo '-------------------------------------'",
      "echo 'create .ssh folder'",
      "mkdir -vp ~/.ssh",
      "echo 'write public key to ~/.ssh/authorized_keys'",
      "cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys", 
      "echo 'delete tmp file'",
      "sudo rm -fv /tmp/id_rsa.pub",
      "echo '-------------------------------------'",
      "echo 'display authorized_keys'",
      "cat ~/.ssh/authorized_keys",      
    ]
  }
}

resource "random_string" "dependency_dummy" {
  depends_on = ["null_resource.ssh_copy"]
  length = 30
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}