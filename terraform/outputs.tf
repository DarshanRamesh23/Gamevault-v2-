output "vpc_id" {
  value = aws_vpc.gamevault_vpc.id
}

output "subnet_id" {
  value = aws_subnet.gamevault_subnet.id
}

output "security_group_id" {
  value = aws_security_group.gamevault_sg.id
}