# Raspberry Pi Terraform Bootstrap Provisioner (Tested with Raspbian Stretch).
# This is a run-once bootstrap Terraform provisioner for a Raspberry Pi.  
# Provisioners by default run only at resource creation, additional runs without cleanup may introduce problems.
# https://www.terraform.io/docs/provisioners/index.html

resource "null_resource" "raspberry_pi_bootstrap" {
  connection {
    type = "ssh"
    user = "${var.username}"
    private_key = "${file("./id_rsa")}"
    host = "${var.ip_adress}"
  }
  
  #You cannot pass any arguments to scripts using the script or scripts arguments to this provisioner. 
  #If you want to specify arguments, upload the script with the file provisioner and then use inline to call it.
  provisioner "file" {
    source      = "./scripts/set_hostname.sh"
    destination = "/tmp/set_hostname.sh"
  }

  provisioner "remote-exec" {
    inline = [
      #make script executable
      "chmod +x /tmp/set_hostname.sh",
      #execute it
      "/tmp/set_hostname.sh ${var.hostname}",    
    ]
  }

  provisioner "file" {
    when = "destroy"
    source      = "./scripts/cleanup_hostname.sh"
    destination = "/tmp/cleanup_hostname.sh"
  }

  provisioner "remote-exec" {
    when = "destroy"
    inline = [
      #make script executable
      "chmod +x /tmp/cleanup_hostname.sh",
      #execute it
      "/tmp/cleanup_hostname.sh",    
    ]
  }
}
