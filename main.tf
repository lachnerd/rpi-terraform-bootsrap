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

  provisioner "remote-exec" {
    inline = [
      # SET HOSTNAME    
      "echo 'hallo'"       
    ]
  }
}
