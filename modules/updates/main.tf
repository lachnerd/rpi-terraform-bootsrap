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

resource "null_resource" "updates" {
  depends_on = ["null_resource.target_group_depends_on"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'updating - start'",
      "echo '-------------------------------------'",
      "echo 'updating apt...'",
      "sudo apt-get update",  
      "echo '-------------------------------------'",
      "echo 'updating - end'",
      "echo '-------------------------------------'",
    ]
  }
}

resource "null_resource" "upgrades" {
  depends_on = ["null_resource.updates"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'upgrading - start'",
      "echo '-------------------------------------'",
      "echo 'upgrading....'",
      "sudo apt-get -qq dist-upgrade -y",      
      "echo '--> All packages up to date now!'",
      "echo 'remove old stuff'",
      "sudo apt-get autoremove -y",
      "echo 'autoclean everything'",  
      "sudo apt-get autoclean",
      "echo 'updating apt again'",
      "sudo apt-get update",
      "echo '-------------------------------------'",
      "echo 'upgrading - end'",
      "echo '-------------------------------------'",
    ]
  }
}

resource "null_resource" "tools" {
  depends_on = ["null_resource.upgrades"]

  connection {
    type = "ssh"    
    user = "${var.user}"
    private_key = "${var.private_key}"
    host = "${var.ip_adress}"
    timeout = "60"
  }

  provisioner "remote-exec" {
    inline = [
      "echo '-------------------------------------'",
      "echo 'install tools - start'",
      "echo '-------------------------------------'",
      "echo 'installing....'",
      "sudo apt-get -qq install mc nano software-properties-common htop curl ncdu apt-transport-https ca-certificates perl rpm gcc make parted jq p7zip-full -y",      
      "echo '-------------------------------------'",
      "echo 'install tools - end'",
      "echo '-------------------------------------'",
    ]
  }
}


resource "random_string" "dependency_dummy" {
  depends_on = ["null_resource.tools"]
  length = 30
  special = false
  min_upper = 8
  min_lower = 8
  min_numeric = 4  
}
