variable "ssh_private_key" {
  description="the tls private key"
}

variable "primary_ip" {
  description="the hosts primary ip-adress"
}

variable "k3s_channel" {
  default = "stable"
} 