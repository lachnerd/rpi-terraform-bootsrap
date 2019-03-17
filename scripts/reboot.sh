#!/bin/bash
echo "-------------------------------------"
echo "reboot"
echo "-------------------------------------"
echo

# reboot
echo "rebooting host in 5s...";
( sleep 5 ; sudo reboot now) &
exit 0
