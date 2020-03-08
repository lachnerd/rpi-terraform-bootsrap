variable "ip_adress" {}
#variable "static_ip_adress" {}

variable "timezone" {
    default = "Europe/London"
}

variable "initial_user" {
    default = "pi"
}
variable "initial_password" {
    default = "raspberry"
}

variable ssh_private_key {}

variable ssh_public_key {}