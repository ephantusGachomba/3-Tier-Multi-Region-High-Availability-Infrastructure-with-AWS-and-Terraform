#create public subnet A in az 1a
resource "aws_subnet" "public_subnet_A" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = var.vpc_id
  tags = {
    Name = "public_subnet_A"
  }
}

#create public subnet B in az 1b
resource "aws_subnet" "public_subnet_B" {
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  vpc_id            = var.vpc_id
  tags = {
    Name = "public_subnet_B"
  }
}

#create private subnet A in az 1a
resource "aws_subnet" "private_subnet_A" {
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = var.vpc_id
  tags = {
    Name = "private_subnet_A"
  }
}

#create private subnet B in az 1b
resource "aws_subnet" "private_subnet_B" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = var.vpc_id
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet_B"
  }
}

#create private subnet C in az 1a
resource "aws_subnet" "private_subnet_C" {
  cidr_block        = "10.0.5.0/24"
  vpc_id            = var.vpc_id
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet_C"
  }
}

#create internet gateway
resource "aws_internet_gateway" "igw_web" {
  vpc_id = var.vpc_id
  tags = {
    Name = "igw_web"
  }
}

#create route table for pub A & pub B
resource "aws_route_table" "rt_public" {
  vpc_id = var.vpc_id
}

#create route for public sub
resource "aws_route" "route_public_subnets" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_web.id
}

#associate route table with public subnets A & B
resource "aws_route_table_association" "rt_ass_public" {
  count          = 2
  subnet_id      = element([aws_subnet.public_subnet_A.id, aws_subnet.public_subnet_B.id], count.index)
  route_table_id = aws_route_table.rt_public.id
}

#create an elastic IP for the NAT gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

#create nat in public subnet A
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_A.id
}

#create route table for private subnets
resource "aws_route_table" "rt_private" {
  vpc_id = var.vpc_id
}

#create route for the private subnet
resource "aws_route" "route_private_subnets" {
  route_table_id         = aws_route_table.rt_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat.id
}

#associate route table with private subnets A B & C
resource "aws_route_table_association" "rt_ass_private" {
  count          = 3
  subnet_id      = element([aws_subnet.private_subnet_A.id, aws_subnet.private_subnet_B.id, aws_subnet.private_subnet_C.id], count.index)
  route_table_id = aws_route_table.rt_private.id
}