#!/bin/bash
echo "-------------------------------------"
echo "current swap status"
echo "-------------------------------------"
free -h
echo

# this disables raspian stretch lite swap
#disable swap
sudo dphys-swapfile swapoff
#uninstall swapfile
sudo dphys-swapfile uninstall
#disable service
sudo systemctl disable dphys-swapfile

echo "-------------------------------------"
echo "new swap status"
echo "-------------------------------------"
free -h