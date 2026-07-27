output "public_ip" {
  value = aws_instance.ingress_server.public_ip
}