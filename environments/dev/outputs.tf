output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.demo.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.demo.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.demo.public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.demo_sg.id
}

output "web_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.demo.public_ip}"
}

output "instance_type" {
  description = "Type of the EC2 instance"
  value       = aws_instance.demo.instance_type
}
