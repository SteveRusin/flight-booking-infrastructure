resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.flight-booking.id

  tags = {
    Name = "flight-booking-igw"
  }
}

resource "aws_eip" "eip_for_nat_gw_a" {
  vpc = true

  tags = {
    Name = "eip_for_nat_gw_a"
  }
}

resource "aws_eip" "eip_for_nat_gw_b" {
  vpc = true

  tags = {
    Name = "eip_for_nat_gw_b"
  }
}

resource "aws_eip" "eip_for_nat_gw_c" {
  vpc = true

  tags = {
    Name = "eip_for_nat_gw_c"
  }
}

resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id     = aws_eip.eip_for_nat_gw_a.id
  subnet_id         = aws_subnet.public_a.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT az 1"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw_b" {
  allocation_id     = aws_eip.eip_for_nat_gw_b.id
  subnet_id         = aws_subnet.public_b.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT az 2"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw_c" {
  allocation_id     = aws_eip.eip_for_nat_gw_c.id
  subnet_id         = aws_subnet.public_b.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT az 3"
  }

  depends_on = [aws_internet_gateway.gw]
}
