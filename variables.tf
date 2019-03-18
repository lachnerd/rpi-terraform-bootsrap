variable "ip_adress" {}
variable "hostname" {}
variable "timezone" {}

variable "initial_user" {
    default = "pi"
}
variable "initial_password" {
    default = "raspberry"
}

variable "new_user" {
    default = "rpi-admin-user"
}

variable "docker_version" {
    default = "18.06.2~ce~3-0~raspbian"
}