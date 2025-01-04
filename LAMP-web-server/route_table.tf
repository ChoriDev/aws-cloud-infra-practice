# Route Table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-rt-${var.vpc_name}"
  }
}

# Route Table Association for public subnets
resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)
  subnet_id = element(aws_subnet.public_for_ec2.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# Route for public subnets
resource "aws_route" "public_igw" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# Route Table for private subnets
resource "aws_route_table" "private" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rt-${count.index}-${var.vpc_name}"
  }
}

# Route Table Association for private subnets
resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)
  subnet_id = element(aws_subnet.private_for_ec2.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

# Route for private subnets
resource "aws_route" "private_nat" {
  count = length(var.availability_zones)
  route_table_id = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = element(aws_nat_gateway.main.*.id, count.index)
}