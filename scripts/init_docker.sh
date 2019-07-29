#!/bin/bash
echo
echo "-------------------------------------"
echo "Passed script arguments:"
echo "-------------------------------------"
for i; do 
    echo $i 
done
echo "-------------------------------------"
echo

echo "-------------------------------------"
echo "Docker"
echo "-------------------------------------"
echo
echo "dpkg --configure -a"
sudo dpkg --configure -a
echo "apt-get install -f"
sudo apt-get install -f -y
echo "update & upgrade"
sudo apt-get update && sudo apt-get upgrade -y
#installation see https://abelperezmartinez.blogspot.com/2019/02/how-to-install-docker-on-raspbian-stretch.html
#install needed software
echo "apt-get install"
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#explicitly setting up the repository into a new docker.list sources file
echo "deb [arch=armhf] https://download.docker.com/linux/raspbian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
#update
sudo apt-get update
#list available versions for info
apt-cache madison docker-ce
#install
sudo apt-get install -y docker-ce=$2 containerd.io
#show version
sudo docker info

echo "add user to docker group to avoid sudo"
sudo usermod -aG docker $1

#display config
echo "-------------------------------------"
echo "Docker"
echo "-------------------------------------"
