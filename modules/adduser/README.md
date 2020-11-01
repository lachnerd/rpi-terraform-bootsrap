# SSH Terraform Module
## Purpose
Generates a RSA private key & public key for authentication.
- Linux/Bash is required
- putty-tools required
  ```
  apt-get install putty-tools
  ```
## Parameters
- ```ssh_folder``` the path to the folder containing all certificate Files
## Output
- ```private_key``` - the rsa private key (content not the file)
- ```public_key``` - the rsa public key (content not the file)
- ```./.ssh/id_rsa.ppk``` - windows compatible private key is generated on linux
## Example
```
module "ssh" {
  source = ".//modules/ssh"
  ssh_folder = "${path.module}/.ssh"
}
```
Results are in ../../.ssh/
