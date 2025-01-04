# Elastic IP for public ec2
resource "aws_eip" "public_ec2" {
  count = length(var.availability_zones)
  instance = element(aws_instance.public_ec2.*.id, count.index)
  domain = "vpc"
  
  tags = {
    Name = "eip-public-ec2-${count.index}"
  }
}

# Elastic IP for nat gateway
resource "aws_eip" "nat_gateway" {
  count = length(var.availability_zones)
  domain = "vpc"
  
  tags = {
    Name = "eip-nat-gateway-${count.index}"
  }
}