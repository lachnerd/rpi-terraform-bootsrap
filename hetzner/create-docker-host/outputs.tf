output "primary_ip" {
  value = try(module.hetzner_host[*].host_ip, {})
  description = "the primary IP address of the host instance."
}

output "hostname" {
  value = try(module.hetzner_host[*].hostname, {})
}

output "backup" {
  value = try(module.hetzner_host[*].backups, {})
}

output "backup_window" {
  value = try(module.hetzner_host[*].backup_window, {})
}

output "server_type" {
  value = try(module.hetzner_host[*].server_type, {})
}

output "server_location" {
  value = try(module.hetzner_host[*].server_location, {})
}

output "server_status" {
  value = try(module.hetzner_host[*].server_status, {})
}

output "private_key" {
  description="tls/ssh private key"
  value = try(module.ssh[*].private_key, {})
}

output "public_key" {
  description="tls/ssh public key"
  value = try(module.ssh[*].public_key, {})
}
