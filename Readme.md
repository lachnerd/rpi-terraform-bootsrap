# Raspberry Pi Initialization with Terraform
This is for Provisioning a Rpi2/3 with [Raspberry Pi OS Lite](https://www.raspberrypi.org/software/operating-systems/). (currently Release date: January 11th 2021 - Kernel version: 5.4) 

I have implemented this for easily bootstrapping RPI Docker Hosts/k3s nodes.

## Current Versions
* Raspberry Pi 3B
  * Transcend Premium 300x 32GB
* Raspberry Pi OS Lite January 11th 2021
* Docker 19.03.14~ce~3-0~raspbian
* Terraform v0.14.07


## Requirements
* Raspberry Pi 2, 3, 4
* SD Card
  * 32GB
  * CLass 10
* SD Card Reader for flashing Raspian
* FLash Program
  * balena Etcher
  * W32 Disk Imager
* Rapsian Image
  * URL: https://www.raspberrypi.org/software/operating-systems/
  * Version: OS lite
* a DHCP Server for getting an IP-Adress

### Terraform binraries installed
* open a bash (here WSL 2 on Windows 10 with Ubuntu)
* ```
  sudo -s
  cd /tmp
  
  #latest tf (2021-02-21)
  export TF_VERSION=0.14.7
  wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
  unzip terraform_${TF_VERSION}_linux_amd64.zip
  mv terraform /usr/local/bin/
  terraform --version
  ```
### kubectl binaries
TODO 


## Manual Steps
### Flashing Image
* Take Flash Program
* unpack Raspberry Pi OS img-File
* Flash it to SD-Card

### Enable one-time ssh Access
* disconnect reader or eject SD-Card and put it back in
* create empty file 'ssh' in boot Partition - this is for initially start the openssh server on the rpi

### Startup Raspberry Pi
* insert SD-Card in RPi
* add network access
* power it up (use proper power solution otherwise you get under voltage errors)
* look in your Router & identify the IP-Adress of RPi 
* write that adress down

## Terraform
Version used: Terraform v0.14.7

### terraform.tfvars
Create a file "terraform.tfvars" for easy adding variable defaults.