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


# this sets RPis new Hostname
# SET HOSTNAME
sudo hostnamectl set-hostname $1

#write hostname to /etc/hosts
echo "127.0.1.1 ${1}" | sudo tee -a /etc/hosts

#test new hostname
getent hosts