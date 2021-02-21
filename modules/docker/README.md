# Terraform docker Module
## Purpose
installs docker-ce with all its dependencies

## Parameters
- ```ssh_private_key```     = tls private key for connection
- ```primary_ip```          = host ip adress
- ```docker_ce_version```   = docker version string according to ubuntu version - "5:19.03.14~3-0~ubuntu-focal" 

## Example
```
module "docker" {
  count = var.nodes
  source = "../../modules/docker"
  depends_on = [module.host_init]
  ssh_private_key = module.ssh[count.index].private_key
  primary_ip = module.hetzner_host[count.index].host_ip
  docker_ce_version = var.docker_ce_version
}
```