resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1a"
  cidr_block              = "10.10.20.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1b"
  cidr_block              = "10.10.21.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_b"
  }
}
resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1c"
  cidr_block              = "10.10.22.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_c"
  }
}

resource "aws_db_subnet_group" "flight-booking" {
  name        = "flight-booking"
  subnet_ids  = [aws_subnet.private_a.id, aws_subnet.private_b.id, aws_subnet.private_c.id]
  description = "flight-booking database subnet group"
}

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt_b.id
}

resource "aws_route_table_association" "c" {
  subnet_id = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_rt_c.id
}
