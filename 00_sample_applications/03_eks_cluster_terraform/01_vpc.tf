resource "aws_vpc" "main_vpc" {
  cidr_block = "10.1.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name" = "${local.env}-main-vpc"
  }
}

# IGW
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    "Name" = "${local.env}-igw"
  }
}

# Subnets: 2 private and 2 public subnets (us-east-1a, us-east-1b)
resource "aws_subnet" "private_zone1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.1.0.0/24"
  availability_zone = local.zone1
  tags = {
    "Name" = "${local.env}-private-${local.zone1}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
resource "aws_subnet" "private_zone2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = local.zone2
  tags = {
    "Name" = "${local.env}-private-${local.zone2}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "public_zone1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.1.10.1/24"
  availability_zone = local.zone1
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${local.env}-public-${local.zone1}"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}
resource "aws_subnet" "public_zone2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.1.11.1/24"
  availability_zone = local.zone2
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${local.env}-public-${local.zone2}"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

# NAT GW
resource "aws_eip" "nat_ip" {
  domain = "vpc"
  tags = {
    "Name" = "${local.env}-nat-ip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id = aws_subnet.public_zone1.id

  tags = {
    "Name" = "${local.env}-nat-gw"
  }
  depends_on = [ aws_internet_gateway.main_igw ]
}

# route tables
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    "Name" = "${local.env}-private-route-table"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    "Name" = "${local.env}-public-route-table"
  }
}

# route table association
resource "aws_route_table_association" "private_rta_zone1" {
  subnet_id = aws_subnet.private_zone1.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_rta_zone2" {
  subnet_id = aws_subnet.private_zone2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_rta_zone1" {
  subnet_id = aws_subnet.public_zone1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_rta_zone2" {
  subnet_id = aws_subnet.public_zone2.id
  route_table_id = aws_route_table.public_route_table.id
}