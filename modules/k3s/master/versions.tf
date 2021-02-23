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
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}