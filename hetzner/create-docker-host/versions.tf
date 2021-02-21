terraform {
  required_providers {
    # third party providers can take minutes to initialize depending on AWS Server speed etc.
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.24.0"
    }
    local = {
      source = "hashicorp/local"
      version = ">= 2.0.0"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
    
    tls = {
      source = "hashicorp/tls"
      version = ">= 3.1.0"
    }

    template = {
      source = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 0.14.7"
}
