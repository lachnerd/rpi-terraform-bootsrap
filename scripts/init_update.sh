#!/bin/bash
echo "-------------------------------------"
echo "current update status"
echo "-------------------------------------"
echo "----------------"
echo "update"
echo "----------------"
sudo apt update -y
echo "----------------"
echo "list updates"
echo "----------------"
sudo apt list --upgradable
echo

#do upgrades
echo "----------------"
echo "list upgrade"
echo "----------------"
sudo apt-get upgrade -y
echo "----------------"
echo "list upgrade kernel"
echo "----------------"
sudo apt-get dist-upgrade -y
#possible broken install fixing
echo "----------------"
echo "fix-broken"
echo "----------------"
sudo apt --fix-broken install -y
echo "----------------"
echo "autoremove"
echo "----------------"
sudo apt-get autoremove -y
echo "----------------"
echo "clean"
echo "----------------"
sudo apt-get clean -y

echo "-------------------------------------"
echo "new update status"
echo "-------------------------------------"
sudo apt update -y
sudo apt list --upgradable