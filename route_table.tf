# Internet gateway - route table

resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }


  tags = {
    Name = "internet-gateway-route-table"
  }
}

# NAT gateway - route table

resource "aws_route_table" "private_to_public_subnet_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-gateway-a.id
  }


  tags = {
    Name = "private-to_public"
  }
}

# Route table association to subnet pulic a
resource "aws_route_table_association" "igw_for_public_a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.igw_route_table.id
}

# Route table association to subnet private a
resource "aws_route_table_association" "private_rt_for_private_a" {
  subnet_id      = aws_subnet.private-subnet-a.id
  route_table_id = aws_route_table.private_to_public_subnet_rt.id
}