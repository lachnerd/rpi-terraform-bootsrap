#!/bin/bash

#adestroys the new user & adds the initial one

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
echo "Add user"
echo "-------------------------------------"
sudo adduser $1 --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "${1}:${2}" | sudo chpasswd
sudo usermod -aG sudo $1
echo

# list all local users
echo "list of all local users"
cut -d: -f1 /etc/passwd
echo
# check if user is sudo
echo "check if user ${1} is sudoer"
sudo -l -U $1
echo

echo "remove new user - ${3}"
sudo userdel ${3}
sudo rm -r -f /home/${3}

#display config
echo "-------------------------------------"
echo "Add user"
echo "-------------------------------------"