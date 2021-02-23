#!/bin/bash

apt-get -yq update
apt-get install -yq \
    ca-certificates \
    curl \
    ntp

# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} K3S_URL=https://${k3s_master_ip}:6443 K3S_TOKEN=${k3s_token} sh -s - \
    --docker \
    --kubelet-arg 'cloud-provider=external'
