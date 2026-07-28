output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.public[*].id 
}

output "first_subnet_id" {
  value = aws_subnet.public[0].id 
}