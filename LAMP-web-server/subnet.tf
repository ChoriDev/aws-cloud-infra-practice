# Public Subnet
# Subnet will use cidr with /24 -> The number of availability IP is 256
resource "aws_subnet" "public" {
  count = length(var.cidr_numeral_public)
  vpc_id = aws_vpc.main.id
  
  cidr_block = "10.0.${var.cidr_numeral_public[count.index]}.0/24"
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "public-${count.index}-${var.vpc_name}"
  }
}

# Private Subnet
# Subnet will use cidr with /24 -> The number of availability IP is 256
resource "aws_subnet" "private" {
  count = length(var.cidr_numeral_private)
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.${var.cidr_numeral_private[count.index]}.0/24"
  availability_zone = element(var.availability_zones, count.index % length(var.availability_zones))

  tags = {
    Name = "private-${count.index}-${var.vpc_name}"
  }
}