#!/bin/bash

#adds a new admin user and deletes the initial one

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
#set password
echo "${1}:${2}" | sudo chpasswd
#sudo usermod -aG sudo $1
#disable password prompt for new user
echo "${1} ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR="tee -a" visudo
echo

# list all local users
echo "list of all local users"
cut -d: -f1 /etc/passwd
echo
# check if user is sudo
echo "check if user ${1} is sudoer"
sudo -l -U $1
echo

echo "remove initial user - ${3}"
sudo userdel ${3}
sudo rm -r -f /home/${3}

#display config
echo "-------------------------------------"
echo "Add user"
echo "-------------------------------------"