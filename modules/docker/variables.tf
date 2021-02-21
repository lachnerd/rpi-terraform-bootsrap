variable "ssh_private_key" {
  description="the tls private key"
}

variable "primary_ip" {
  description="the hosts primary ip-adress"
}

variable "docker_ce_version" {
  description="docker ce version string: apt-cache madison docker-ce"
}

variable "docker_dns_1" {
  description="Cloudflare Primary"
  default="1.1.1.1"
}

variable "docker_dns_2" {
  description="Google Primary"
  default="8.8.8.8"
}

variable "docker_dns_3" {
  description="Cloudflare Secondary"
  default="1.0.0.1"
}

variable "docker_dns_4" {
  description="Google Secondary"
  default="8.8.4.4"
}