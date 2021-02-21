# SSH Module

## Purpose
Generates a RSA private key & public key for authentication.
Linux/Bash is required

## Parameters
- ```ssh_folder``` the path to the folder containing all certificate Files

## Output
- ```private_key``` - the rsa private key (content not the file)
- ```public_key``` - the rsa public key (content not the file)
- ```./.ssh/id_rsa.ppk``` - windows compatible private key is generated on linux

## Example
```
module "ssh" {
  count = var.nodes
  source = "../../modules/ssh"
  ssh_folder = "${local.ssh_folder}/${count.index}/"
}
```
Results are in ../../.ssh/
