resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
      Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "talent-academy-main-IGW"
  }
}

resource "aws_subnet" "public-subnet-a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.11.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}a"

  tags = {
    Name = "talent-academy-PUBLIC-SUBNET-a"
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.12.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}b"

  tags = {
    Name = "talent-academy-PUBLIC-SUBNET-b"
  }
}

resource "aws_subnet" "public-subnet-c" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.13.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.region}c"

  tags = {
    Name = "talent-academy-PUBLIC-SUBNET-c"
  }
}

resource "aws_subnet" "private-subnet-a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.21.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "talent-academy-PRIVATE-SUBNET-a"
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.22.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "talent-academy-PRIVATE-SUBNET-b"
  }
}

resource "aws_subnet" "private-subnet-c" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "192.168.23.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "talent-academy-PRIVATE-SUBNET-c"
  }
}

# Elastic IPs for the NATs
resource "aws_eip" "nat-a-eip" {
  vpc      = true
}

resource "aws_eip" "nat-b-eip" {
  vpc      = true
}

resource "aws_eip" "nat-c-eip" {
  vpc      = true
}

resource "aws_nat_gateway" "NAT-gateway-a" {
  subnet_id     = aws_subnet.public-subnet-a.id
  allocation_id = aws_eip.nat-a-eip.id
  tags = {
    Name = "NAT Gateway A"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet-gateway]
}

resource "aws_nat_gateway" "NAT-gateway-b" {
  subnet_id     = aws_subnet.public-subnet-b.id
  allocation_id = aws_eip.nat-b-eip.id
  tags = {
    Name = "NAT Gateway B"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet-gateway]
}

resource "aws_nat_gateway" "NAT-gateway-c" {
  subnet_id     = aws_subnet.public-subnet-c.id
  allocation_id = aws_eip.nat-c-eip.id
  tags = {
    Name = "NAT Gateway C"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet-gateway]
}
