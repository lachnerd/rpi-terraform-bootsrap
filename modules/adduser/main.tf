/******************************************************************************************************
 * add user
 * adds a new user
 ******************************************************************************************************/

resource "random_string" "password" {
  length = 24
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}

resource "null_resource" "target_group_depends_on" {
  triggers = {
    # The reference to the variable here creates an implicit
    # dependency on the variable.
    # content is an output variable from a source module
    dependency = "${var.target_group_depends_on}"
  }
}

resource "null_resource" "adduser" {
  depends_on = ["null_resource.target_group_depends_on"]

  connection {
    type = "ssh"    
    user = "${var.initial_user}"
    password = "${var.initial_password}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'Add user'",
      "echo '-------------------------------------'",
      "sudo adduser ${var.user} --gecos 'First Last,RoomNumber,WorkPhone,HomePhone' --disabled-password",
      "echo 'set password'",
      "echo '${var.user}:${random_string.password.result}' | sudo chpasswd",
      #sudo usermod -aG sudo $1
      "echo 'disable password prompt for new user'",
      "echo '${var.user} ALL=(ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo",
      # list all local users
      "echo 'list all local users'",
      "echo '-------------------------------------'",
      "cut -d: -f1 /etc/passwd",
      "echo 'check if user ${var.user} is sudoer'",
      "sudo -l -U ${var.user}",
    ]
  }
}