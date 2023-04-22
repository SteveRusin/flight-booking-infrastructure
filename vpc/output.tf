output "vpc_id" {
  value = aws_vpc.flight-booking.id
}
output "vpc_cidr" {
  value = aws_vpc.flight-booking.cidr_block
}

output "subnet_id" {
  value = {
    a = aws_subnet.public_a.id,
    b = aws_subnet.public_b.id,
    c = aws_subnet.public_c.id
  }
}

output "private_db_subnet_id" {
  value = {
    a = aws_subnet.private_db_a.id,
    b = aws_subnet.private_db_b.id,
    c = aws_subnet.private_db_c.id
  }
}

output "gateway_id" {
  value = aws_internet_gateway.gw.id
}

output "aws_db_subnet_group_name" {
  value = aws_db_subnet_group.flight-booking.name
}