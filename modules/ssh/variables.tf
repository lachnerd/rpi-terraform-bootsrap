variable "ip_adress" {}

variable "ssh_folder" {
  description="the path containing the ssh key files"
}

variable "timezone" {
    default = "Europe/London"
}

variable "initial_user" {
    default = "pi"
}
variable "initial_password" {
    default = "raspberry"
}

