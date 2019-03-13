output "timezone" {
  value = "${var.timezone}"
  description = "the devices timezone"
}

output "dependency_output" {
  value = "${null_resource.timezone.id}"
}