# NETWORKING
resource "aws_vpc" "app" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

}

# INTERNET GATEWAY
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.app.id
  tags = {
    Name = "IGW-CondoMatics-S25"
  }
}

# SUBNET
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.app.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# ROUTE TABLE
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.app.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "pulic_subnet_route_table" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}