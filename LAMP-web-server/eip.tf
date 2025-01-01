# Elastic IP for public ec2
resource "aws_eip" "public_ec2" {
  count = length(var.cidr_numeral_public)
  instance = element(aws_instance.public_ec2.*.id, count.index)
  domain = "vpc"
  
  tags = {
    Name = "eip-public-ec2-${count.index}"
  }
}