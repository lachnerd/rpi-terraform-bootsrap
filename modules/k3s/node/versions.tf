# ------------------------------------------------------------------------------
# version restrictions
# ------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.14.5"

  required_providers {    
    null = {
      source = "hashicorp/null"
      version = ">= 3.0.0"
    }
  }
}