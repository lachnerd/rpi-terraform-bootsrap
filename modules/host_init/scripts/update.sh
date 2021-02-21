#!/bin/bash
echo "========================================="
echo "updates.sh - START"
echo "========================================="
echo
apt-get update
#disable interactive Frontend
export DEBIAN_FRONTEND=noninteractive
#--force-yes ist zwar deprecated funzt aber noch
#W: --force-yes is deprecated, use one of the options starting with --allow instead.
apt-get dist-upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes
echo "--> All packages up to date now!"
apt-get autoremove -y
apt-get autoclean
echo "install tools..."
apt-get -qq install mc nano software-properties-common htop curl ncdu apt-transport-https ca-certificates perl rpm gcc make parted jq p7zip-full -y
echo "========================================="
echo "updates.sh - FINISH"
echo "========================================="
echo