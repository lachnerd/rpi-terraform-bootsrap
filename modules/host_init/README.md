# Terraform host_init Module
## Purpose
configures ssh, installs updates & fail2ban

## Parameters
- ```ssh_private_key```     = tls private key for connection
- ```primary_ip```          = host ip adress

## Example
```
module "host_init" {
  count = var.nodes
  source = "../../modules/host_init"
  depends_on = [module.hetzner_host]
  ssh_private_key = module.ssh[count.index].private_key
  primary_ip = module.hetzner_host[count.index].host_ip
}
```