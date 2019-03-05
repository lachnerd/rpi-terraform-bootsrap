# Raspberry Pi Initialization with Terraform
This is for Provisioning a Rpi2/3 with Raspian Lite

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

### Generate SSH Key for easy connection to RPi
* Generate SSH Key following this [article](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
* open bash (linux/windows/git bash)
* ```bash
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  ```
* Enter no Passphrase 
* Save Private & Public Key

### Copy SSH Key to RPi
* 2 Variants available
#### ssh-copy-id
```bash
   ssh-copy-id pi@<IP-ADDRESS>
   password: raspberry
```
#### manually
```bash
$cat ~/.ssh/id_rsa.pub | ssh pi@<IP-ADRESS> "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
The authenticity of host '<IP-ADRESS> (<IP-ADRESS>)' can't be established.
ECDSA key fingerprint is SHA256:TDaxHjcZfoPqgvY2Mq0RVvcakKlEsU9AntEzicUXl6U.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '<IP-ADRESS>' (ECDSA) to the list of known hosts.
pi@<IP-ADRESS>'s password: raspberry
```
*

