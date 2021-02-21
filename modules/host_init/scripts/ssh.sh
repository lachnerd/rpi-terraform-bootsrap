#!/bin/bash
echo "========================================="
echo "ssh.sh - START"
echo "========================================="
echo
echo "changing default port to 2222"
#in 20.04 Port is default commented out
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
echo "setting strictModes yes explicitly"
sed -i 's/#StrictModes yes/StrictModes yes/g' /etc/ssh/sshd_config
echo "setting PubkeyAuthentication yes explicitly"
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
echo "reload ssh config"
service ssh reload
echo "========================================="
echo "ssh.sh - FINISH"
echo "========================================="
echo
