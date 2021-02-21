variable "ssh_private_key" {
  description="the tls private key"
}

variable "primary_ip" {
  description="the hosts primary ip-adress"
}

variable "k3s_master_ip" {
  description="the primary ip-adress of the k3s master node"
}

variable "k3s_channel" {
  default = "stable"
}

variable "k3s_token" {
  description="the k3s registration token"
}