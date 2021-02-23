# k3s node module
## Purpose
installs k3s nodes and connects to k3s master


## Parameters
- ```ssh_private_key```     = tls private key for connection
- ```primary_ip```          = host ip adress

## Output
none

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

## Docs
https://www.osradar.com/how-to-install-kubernetes-cluster-on-ubuntu-20-04-using-k3s/

https://registry.terraform.io/modules/cicdteam/k3s/hcloud/latest

https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/

