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
#ersetzt 'raspberrypi' mit variable
sudo sed -i "s/raspberrypi/${1}/g" /etc/hosts

#test new hostname
getent hosts