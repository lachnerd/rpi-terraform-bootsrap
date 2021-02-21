#!/bin/bash
echo "========================================="
echo "docker - START"
echo "========================================="
echo
if [ -z "$1" ]
  then
    echo "No argument for docker version supplied"
    exit 1
fi
if [ -z "$2" ]
  then
    echo "No argument for dns server #1  supplied"
    exit 1
fi
if [ -z "$3" ]
  then
    echo "No argument for dns server #2  supplied"
    exit 1
fi
if [ -z "$4" ]
  then
    echo "No argument for dns server #3  supplied"
    exit 1
fi
if [ -z "$5" ]
  then
    echo "No argument for dns server #4  supplied"
    exit 1
fi

apt-get update
apt-get -qq install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
echo "install docker"
#see versions with: apt-cache madison docker-ce
#e.g. 18.06.3~ce~3-0~ubuntu, 5:18.09.9~3-0~ubuntu-xenial, 
apt-get -qq install docker-ce=${1} -y
echo "hold docker-ce etc. to prevent accidental engine upgrades"
apt-mark hold docker-ce containerd.io docker-ce-cli
echo "display docker info"
docker info
#configure localhost tcp access to docker
echo "DOCKER_OPTS"
# DNS CCC,OpenDNS,Google, localhost
echo "DOCKER_OPTS=\"--dns ${2} --dns ${3} --dns ${4} --dns ${5} -H tcp://0.0.0.0:2376\"" >> /etc/default/docker
echo
echo "adding CCC, OpenDNS and Google DNS Servers to Docker"
cat >/etc/docker/daemon.json <<EOL
{
    "dns":["${2}","${3}","${4}","${5}"]
}
EOL
# check docker install
#https://medium.com/@valkyrie_be/quicktip-a-universal-way-to-check-if-docker-is-running-ffa6567f8426

echo "========================================="
echo "docker - FINSIH"
echo "========================================="