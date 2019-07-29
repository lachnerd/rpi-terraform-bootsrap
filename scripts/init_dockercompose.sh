#!/bin/bash
#source https://manre-universe.net/how-to-run-docker-and-docker-compose-on-raspbian/
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
echo "Docker-Compose"
echo "-------------------------------------"
echo
echo "python install"
sudo apt-get install -y python python-pip
echo "install docker-compose"
sudo pip install docker-compose
echo "test"
docker-compose -version

echo "-------------------------------------"
echo "Docker-Compose"
echo "-------------------------------------"
