variable "ip_adress" {}
variable "hostname" {
    default = "rpi-host"
}

variable "initial_user" {
    default = "pi"
}
variable "initial_password" {
    default = "raspberry"
}

variable "user" {
    default = "rpi-admin-user"
}

variable "timezone" {
    default = "Europe/Berlin"
}

variable "docker_version" {
    default = "18.06.2~ce~3-0~raspbian"
}