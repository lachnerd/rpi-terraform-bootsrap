#!/bin/bash
echo "-------------------------------------"
echo "current swap status"
echo "-------------------------------------"
free -h
echo

# this enables raspian stretch lite swap
#enable service
sudo systemctl enable dphys-swapfile
#setup swapfile
sudo dphys-swapfile setup
#enable swap
sudo dphys-swapfile swapon



echo "-------------------------------------"
echo "new swap status"
echo "-------------------------------------"
free -h