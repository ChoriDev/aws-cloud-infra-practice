# Public Subnet for ec2
# Subnet will use cidr with /24 -> The number of availability IP is 256
resource "aws_subnet" "public_for_ec2" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  
  cidr_block = "10.0.${var.cidr_numeral_public_ec2[count.index]}.0/24"
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "public-${count.index}-${var.vpc_name}"
  }
}

# Private Subnet for ec2
# Subnet will use cidr with /24 -> The number of availability IP is 256
resource "aws_subnet" "private_for_ec2" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  cidr_block = "10.0.${var.cidr_numeral_private_ec2[count.index]}.0/24"
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private-${count.index}-${var.vpc_name}"
  }
}