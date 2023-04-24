resource "aws_subnet" "private_lambda_a" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1a"
  cidr_block              = "10.10.30.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_lambda_a"
  }
}

resource "aws_subnet" "private_lambda_b" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1b"
  cidr_block              = "10.10.31.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_lambda_b"
  }
}
resource "aws_subnet" "private_lambda_c" {
  vpc_id                  = aws_vpc.flight-booking.id
  availability_zone       = "eu-west-1c"
  cidr_block              = "10.10.32.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_lambda_c"
  }
}

resource "aws_route_table_association" "lambda_a" {
  subnet_id = aws_subnet.private_lambda_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route_table_association" "lambda_b" {
  subnet_id = aws_subnet.private_lambda_b.id
  route_table_id = aws_route_table.private_rt_b.id
}

resource "aws_route_table_association" "lambda_c" {
  subnet_id = aws_subnet.private_lambda_c.id
  route_table_id = aws_route_table.private_rt_c.id
}
