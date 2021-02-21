# ------------------------------------------------------------------------------
# version restrictions
# ------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.14.7"

  required_providers {
    # der Hetzner provider kann extrem lange brauchen um zu initialisieren > 5min
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "= 1.24.0"
    }
    
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}