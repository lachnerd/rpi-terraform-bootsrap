#!/bin/bash

# destroy script
# reverting all hostname changes

echo
echo "-------------------------------------"
echo "Passed script arguments:"
echo "-------------------------------------"
for i; do 
    echo $i 
done
echo "-------------------------------------"
echo

# SET HOSTNAME to raspberrypi
sudo hostnamectl set-hostname raspberrypi

#create tmp file
touch /tmp/hosts

#writing defaults to /tmp/hosts
sudo echo "127.0.0.1       localhost" | sudo tee -a /tmp/hosts
sudo echo "127.0.0.1       localhost ip6-localhost ip6-loopback" | sudo tee -a /tmp/hosts
sudo echo "ff02::1         ip6-allnodes" | sudo tee -a /tmp/hosts
sudo echo "ff02::2         ip6-allrouters" | sudo tee -a /tmp/hosts

#copy /tmp/hosts over /etc/hosts
sudo cp /tmp/hosts /etc/hosts

#test hostname
echo
echo "-------------------------------------"
echo "display hosts"
echo "-------------------------------------"
getent hosts