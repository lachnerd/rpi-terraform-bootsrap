#!/bin/bash

#cleanup timezone settings

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
echo "Current Time Zone"
echo "-------------------------------------"
cat /etc/timezone
echo

# this sets RPis Timezone
# SET Time Zone
sudo timedatectl set-timezone Europe/London

# Network time should be true by default but to be sure...
sudo timedatectl set-ntp true

#display config
echo "-------------------------------------"
echo "New Time Zone"
echo "-------------------------------------"
timedatectl