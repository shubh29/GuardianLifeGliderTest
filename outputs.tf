# outputs.tf

output "instance_public_ip" {
  description = "Instance IP"
  value       = aws_instance.web.public_ip
}

