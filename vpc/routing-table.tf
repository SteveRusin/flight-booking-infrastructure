resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.flight-booking.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "public_rt"
  }
}

resource "aws_main_route_table_association" "public_rt" {
  vpc_id         = aws_vpc.flight-booking.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.flight-booking.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_a.id
  }
}

resource "aws_route_table" "private_rt_b" {
  vpc_id = aws_vpc.flight-booking.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_b.id
  }
}
resource "aws_route_table" "private_rt_c" {
  vpc_id = aws_vpc.flight-booking.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_c.id
  }
}
