# Terraform ufw Module
## Purpose
the universal firewall configured & activated

## Input
- ```ssh_private_key```         = tls private key for connection
- ```primary_ip```              = host ip adress

## Example
```
module "ufw" {
  count = var.nodes
  source = "../../modules/ufw"
  depends_on = [module.prtg]
  ssh_private_key = module.ssh[count.index].private_key
  primary_ip = module.hetzner_host[count.index].host_ip
}
```

## Docs
https://wiki.ubuntu.com/UncomplicatedFirewall