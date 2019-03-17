output "ip_adress" {
  value = "${var.ip_adress}"
  description = "device ip adress"  
}

output "admin_user_password" {
  value = "${random_string.password.result}" 
}

/*output "hostname" {
  value = "${module.hostname.hostname}"
  description = "the new hostname - this is no real output cause its no computed value"
}

output "timezone" {
  value = "${module.timezone.timezone}"
  description = "the new timezone - this is no real output cause its no computed value"
}*/