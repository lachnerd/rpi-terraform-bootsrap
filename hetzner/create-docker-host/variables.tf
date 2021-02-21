variable "nodes" {
  description="how many server nodes should be created"
  default=1
}

variable "hcloud_token" {}

variable "docker_ce_version" {
  description="docker ce version string: apt-cache madison docker-ce"
  #focal = 20.04
  default="5:19.03.14~3-0~ubuntu-focal" 
}

variable "server_host_name" {
  description="the server hostname - if the name is null a generated 2 word random pet name is used"
  default=null
}

variable "server_type" {
  description="the hetzner server type - case sensitive!"
  default="cx11"
  validation {
    condition     = can(regex("^cx11$|^cpx11$|^cx21$|^cpx21$|^cx31$|^cpx31$|^cx41$|^cpx41$|^cx51$|^cpx51$|^ccx11$|^ccx21$|^ccx31$|^ccx41$|^ccx51$", var.server_type))
    error_message = "Hetzner server_type is not valid - its also case sensitive!"
  }
}

# enables/disables the server backup service
variable "server_backup" {
  default=true
}
