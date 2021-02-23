# k3s master module
## Purpose
installs k3s master

## Parameters
- ```ssh_private_key```     = tls private key for connection
- ```primary_ip```          = host ip adress

## Output
- ```k3s_master_ip```       = the ip adress of the master node
- ```k3s_token```           = the host token for connection

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


- ```--flannel-backend=vxlan```
  see https://containerlabs.kubedaily.com/rancher/Networking/Networking-with-Flannel.html
  - vxlan
    - default
    - Fast, but with no interhost encryption
    - Suitable for private/secure networks
  - ipsec
    - Encrypts traffic between hosts
    - Suitable when traffic traverses the Internet
  - host-gw
    - Good performance
    - Cloud agnostic
  - wireguard
    - ?
- ```--disable-cloud-controller```

  as the name suggests disables default k3s cloud controller. We need to do that otherwise k3s will use it’s own builtin “dummy” cloud controller.
- ```--disable servicelb```

  we ask k3s to not deploy servicelb because it would mess up IP addresses
  ```--disable local-storage```

  disable only if another storage provider is available otherwise PVC are not working out of the box