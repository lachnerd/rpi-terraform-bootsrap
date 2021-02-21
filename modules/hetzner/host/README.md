# Terraform hetzner Module
## Purpose
configures hetzner cloud server

## Input Variables
- ```ssh_public_key```     = tls public key for connection
- ```api_token```          = hcloud api token for a hetzner cloud project
- ```name```               = name, a server name consiting from name if defined and 2 word random pet name e.g. 'foo-fuzzy-ginko' or only fuzzy-ginko
- ```server_type```        = server type & dimensions

## Output Variables

## Example
```
module "hetzner_host" {
  count = var.nodes  
  source = "../../modules/hetzner/host"
  index = count.index
  ssh_public_key = module.ssh[count.index].public_key_openssh
  api_token = var.hcloud_token
  name = var.server_host_name
  server_type = var.server_type
  backups = var.server_backup
}
```