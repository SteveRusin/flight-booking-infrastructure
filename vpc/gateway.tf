resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.flight-booking.id

  tags = {
    Name = "flight-booking-igw"
  }
}

resource "aws_eip" "eip_for_nat_gw_az1" {
  vpc = true

  tags = {
    Name = "eip_for_nat_gw_az1"
  }
}

resource "aws_eip" "eip_for_nat_gw_az2" {
  vpc = true

  tags = {
    Name = "eip_for_nat_gw_az2"
  }
}

resource "aws_eip" "eip_for_nat_gw_az3" {
  vpc = true

  tags = {
    Name = "eip_for_nat_gw_az3"
  }
}

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id     = aws_eip.eip_for_nat_gw_az1.id
  subnet_id         = aws_subnet.public_a.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT az 1"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id     = aws_eip.eip_for_nat_gw_az2.id
  subnet_id         = aws_subnet.public_b.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT az 2"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw_az3" {
  allocation_id     = aws_eip.eip_for_nat_gw_az3.id
  subnet_id         = aws_subnet.public_b.id
  connectivity_type = "public"

  tags = {
    Name = "gw NAT az 3"
  }

  depends_on = [aws_internet_gateway.gw]
}
