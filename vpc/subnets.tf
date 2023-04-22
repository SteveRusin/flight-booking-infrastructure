
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1a"
  cidr_block              = cidrsubnet(aws_vpc.flight-booking.cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "public_a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1b"
  cidr_block              = cidrsubnet(aws_vpc.flight-booking.cidr_block, 8, 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "public_b"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1c"
  cidr_block              = cidrsubnet(aws_vpc.flight-booking.cidr_block, 8, 3)
  map_public_ip_on_launch = true

  tags = {
    Name = "public_b"
  }
}

resource "aws_route_table_association" "public_a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_a.id
}

resource "aws_route_table_association" "public_b" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_b.id
}

resource "aws_route_table_association" "public_c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_c.id
}
