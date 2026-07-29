output "monitoring_public_ip" {
  description = "The public IP of the monitoring server"
  value       = aws_eip.monitoring_eip.public_ip
}