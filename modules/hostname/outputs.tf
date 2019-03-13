output "hostname" {
  value = "${var.hostname}"
  description = "the devices hostname"
}

output "dependency_output" {
  value = "${null_resource.hostname.id}"
}