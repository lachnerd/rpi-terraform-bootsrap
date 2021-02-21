# ------------------------------------------------------------------------------
# version restrictions
# ------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.14.7"

  required_providers {    
    null = {
      source = "hashicorp/null"
      version = ">= 3.1.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = ">= 3.1.0"
    }
    local = {
      source = "hashicorp/local"
      version = ">= 2.0.0"
    }
  }
}