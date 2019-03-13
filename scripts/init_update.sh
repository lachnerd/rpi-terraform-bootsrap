#!/bin/bash
echo "-------------------------------------"
echo "current update status"
echo "-------------------------------------"
sudo apt update -y
sudo apt list --upgradable
echo

#do upgrades
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
#possible broken install fixing
sudo apt --fix-broken install -y
sudo apt-get autoremove -y
sudo apt-get clean -y

echo "-------------------------------------"
echo "new update status"
echo "-------------------------------------"
sudo apt update -y
sudo apt list --upgradable