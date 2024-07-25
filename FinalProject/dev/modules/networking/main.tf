# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

   tags = {
    Name = var.vpc_tag
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

#creating public subnet
resource "aws_subnet" "public_subnet" {
 count      = length(var.public_subnet_cidr)
 vpc_id     = aws_vpc.vpc.id
 cidr_block = element(var.public_subnet_cidr, count.index)
 availability_zone = element(var.azs, count.index)

 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
# creating route table for public subnet 
resource "aws_route_table" "route_tb1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_asso" {
 count          = length(var.public_subnet_cidr)
 subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
 route_table_id = aws_route_table.route_tb1.id
}

resource "aws_subnet" "private_subnet" {
 count      = length(var.private_subnet_cidr)
 vpc_id     = aws_vpc.vpc.id
 cidr_block = element(var.private_subnet_cidr, count.index)
 availability_zone = element(var.azs, count.index)

 tags = {
   Name = "Private Subnet ${count.index + 1}"
 } 
 }
 resource "aws_eip" "eip" {
  vpc = true
}
# creating nat gatway 

 resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on = [aws_internet_gateway.igw]
}

# creating  route table for private subnet

resource "aws_route_table" "route_tb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_nat_gateway.ngw.id
  }
tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private_asso" {
 count = length(var.private_subnet_cidr)
 subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
 route_table_id = aws_route_table.route_tb.id
}

# Create a security group for the instances in the private subnet
resource "aws_security_group" "security_gp" {
  name        = var.security_group_name
  description = var.description

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [
      var.lb_sg_id
    ]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


