output "public_ip" {
  value       = aws_eip.ingress_eip.public_ip
  description = "The static Elastic IP attached to the Ingress Server"
}