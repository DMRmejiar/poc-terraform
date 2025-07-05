# ==============================================
# OUTPUTS USING MODULE OUTPUTS
# ==============================================

# Primary Server Outputs
output "primary_instance_id" {
  description = "ID of the primary EC2 instance"
  value       = module.primary_server.instance_id
}

output "primary_instance_public_ip" {
  description = "Public IP address of the primary EC2 instance"
  value       = module.primary_server.instance_public_ip
}

output "primary_web_url" {
  description = "URL to access the primary web server"
  value       = module.primary_server.web_url
}

# Secondary Server Outputs (será agregado en el próximo commit)
# output "secondary_instance_id" {
#   description = "ID of the secondary EC2 instance"
#   value       = module.secondary_server.instance_id
# }
#
# output "secondary_instance_public_ip" {
#   description = "Public IP address of the secondary EC2 instance"
#   value       = module.secondary_server.instance_public_ip
# }
#
# output "secondary_web_url" {
#   description = "URL to access the secondary web server"
#   value       = module.secondary_server.web_url
# }

# Security Group Outputs
output "security_group_id" {
  description = "ID of the security group (shared by both instances)"
  value       = module.security_group.security_group_id
}

# General Outputs
output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "total_instances" {
  description = "Total number of instances deployed"
  value       = 1  # Solo servidor primario por ahora
}
