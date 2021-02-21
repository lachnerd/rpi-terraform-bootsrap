# ------------------------------------------------------------------------------
# module configuration variables
# ------------------------------------------------------------------------------
variable "index" {
}

# ------------------------------------------------------------------------------
# module input variables
# ------------------------------------------------------------------------------
variable "ssh_public_key" {
  description="the tls public key"
}

variable "api_token" {
  description="the api token to access hetzner cloud project"
}

variable "name" {
  description="Name of the server to create (must be unique per project and a valid hostname as per RFC 1123)"
  default = null
}

# cx11, cpx11, cx21 ...
# siehe hetzner cloud - server_type is case sensitive!
variable "server_type" {
  description="Name of the server type (Node type size) this server should be created with"
  default="cx11"
  validation {
    condition     = can(regex("^cx11$|^cpx11$|^cx21$|^cpx21$|^cx31$|^cpx31$|^cx41$|^cpx41$|^cx51$|^cpx51$|^ccx11$|^ccx21$|^ccx31$|^ccx41$|^ccx51$", var.server_type))
    error_message = "Node type is not valid."
  }
}

variable "image" {
  description="Name or ID of the image the server is created from"
  default="ubuntu-20.04"
}

# nbg1, fsn1, hel1
variable "location" {
  description="The location name to create the server in"
  default="nbg1"
  validation {
    condition     = can(regex("^nbg1$|^fsn1$|^hel1$", var.location))
    error_message = "Hetzner cloud location was not found."
  }
}

variable "backups" {
  description="Enable or disable backups"
  default=false
}