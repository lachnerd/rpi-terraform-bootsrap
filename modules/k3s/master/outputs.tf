output "k3s_token" {
  value = try(random_string.k3s_token.result, {})
  description = "k3s_token for registering additional k3s workers"
}

output "k3s_master_ip" {
  value = try(var.primary_ip, {})
  description = "host_primary_ip of the generated ionos host object"
}