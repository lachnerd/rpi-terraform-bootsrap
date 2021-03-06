variable "ip_adress" {}
variable "hostname" {
    default = "rpi-host"
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

variable "new_user" {
    default = "rpi-admin-user"
}

variable "docker_version" {
    default = "18.06.2~ce~3-0~raspbian"
}