output "host_ip" {
  value = try(hcloud_server.node.ipv4_address, {})
  description = "ipv4_address of the generated hetzner node object"
}

output "hostname" {
  value = try(hcloud_server.node.name, {})
  description = "Name of the server"
}

output "backups" {
  value = try(hcloud_server.node.backups, {})
  description = "Whether backups are enabled"
}

output "backup_window" {
  value = try(hcloud_server.node.backup_window, {})
  description = "The backup window of the server, if enabled."
}

output "server_type" {
  value = try(hcloud_server.node.server_type, {})
  description = "Name of the server type."
}

output "server_location" {
  value = try(hcloud_server.node.location, {})
  description = "The location name."
}

output "server_status" {
  value = try(hcloud_server.node.status, {})
  description = "The status of the server."
}