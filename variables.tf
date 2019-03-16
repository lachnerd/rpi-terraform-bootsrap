variable "ip_adress" {}
variable "hostname" {}
variable "timezone" {}
variable "static_ip_and_mask" {}
variable "static_router" {}
variable "static_dns" {}
variable "private_key_path" {}

variable "public_key_path" {
    default = "id_rsa.pub" 
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