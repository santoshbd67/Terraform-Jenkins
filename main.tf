# Provider Configuration
provider "aws" {
  region = var.region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create NAT Gateway EIP
resource "aws_eip" "nat_eip" {
  vpc = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "my-nat-gateway"
  }
}

# Create Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "my-public-route-table"
  }
}

# Create Route Table for Private Subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }
  tags = {
    Name = "my-private-route-table"
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnet" {
  count                  = length(var.public_subnet_cidrs)
  vpc_id                 = aws_vpc.my_vpc.id
  cidr_block             = element(var.public_subnet_cidrs, count.index)
  availability_zone      = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private_subnet" {
  count                  = length(var.private_subnet_cidrs)
  vpc_id                 = aws_vpc.my_vpc.id
  cidr_block             = element(var.private_subnet_cidrs, count.index)
  availability_zone      = element(var.azs, count.index)
  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# Associate Subnets with Route Tables
resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

# Launch an EC2 instance in the Public Subnet
resource "aws_instance" "public_instance" {
  ami           = var.public_instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "PublicInstance"
  }
}

# Launch an EC2 instance in the Private Subnet
resource "aws_instance" "private_instance" {
  ami           = var.private_instance_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet[0].id
  tags = {
    Name = "PrivateInstance"
  }
}
