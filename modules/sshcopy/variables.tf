#on tf 0.12 can be replaced with dirname() function
variable "target_group_depends_on" {
  type    = "string" # (because "any" isn't supported in 0.11)
  default = ""
}

variable "user" {}

variable "password" {}

variable "ip_adress" {}

variable "ssh_public_key" {}