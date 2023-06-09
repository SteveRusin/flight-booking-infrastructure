resource "aws_subnet" "private_db_a" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1a"
  cidr_block              = "10.10.20.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_a"
  }
}

resource "aws_subnet" "private_db_b" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1b"
  cidr_block              = "10.10.21.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_b"
  }
}
resource "aws_subnet" "private_db_c" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1c"
  cidr_block              = "10.10.22.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_db_c"
  }
}

resource "aws_route_table_association" "db_a" {
  subnet_id = aws_subnet.private_db_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "db_b" {
  subnet_id = aws_subnet.private_db_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "db_c" {
  subnet_id = aws_subnet.private_db_c.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_db_subnet_group" "flight_booking" {
  name        = "flight-booking"
  subnet_ids  = [aws_subnet.private_db_a.id, aws_subnet.private_db_b.id, aws_subnet.private_db_c.id]
  description = "flight booking postgres database subnet group"
}
