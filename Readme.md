# Raspberry Pi Initialization with Terraform
This is for Provisioning a Rpi2/3 with Raspian Lite. 
I have implemented this for easily bootstrapping RPI Docker Hosts

## Current Versions
* Raspberry Pi 3B
  * Transcend Premium 300x 32GB
* Raspian 2018-11-13-raspbian-stretch-lite
* Docker 18.06.2~ce~3-0~raspbian
* Terraform v0.11.11


## Requirements
* Raspberry Pi 2 or 3
* SD Card
  * 16GB or better 32GB
* SD Card Reader for flashing Raspian
* FLash Program
  * balena Etcher
  * W32 Disk Imager
* Rapsian Image
  * URL: https://www.raspberrypi.org/downloads/raspbian/
  * Version: 2018-11-13-raspbian-stretch-lite.zip
* a DHCP Server for getting a IP-Adress

## Manual Steps
### Flashing Image
* Take Flash Program
* unpack Rapsian img-File
* Flash it to SD-Card

### Enable one-time ssh Access
* disconnect reader or eject SD-Card and put it back in
* create empty file 'ssh' in boot Partition

### Startup Raspberry Pi
* insert SD-Card in RPi
* add network access
* power it up
* look in your Router & identify the IP-Adress of RPi 
* write that adress down

## Terraform
Version used: Terraform v0.11.11

### terraform.tfvars
Create a file "terraform.tfvars" for easy adding variable defaults.
Te only variable that must be set is "ip_adress" for initial connection to Raspberry Pi.
An Example File "terraform.tfvars.example" is included.

### initialize
Before first use terraform modules must be initialized
```bash
   terraform init
```

### plan
```bash
   terraform plan
```

### apply
```bash
   terraform apply
```
* approve with: yes
* terraform will do the following
  * generate a tls key
  * copy public key to rpi
  * adds a new admin user
  * generate a new password
  * first connect with user & password
  * connect with private key


### destroy
```bash
   terraform destroy
```
Not every single ressource has destroy abilities yet.
