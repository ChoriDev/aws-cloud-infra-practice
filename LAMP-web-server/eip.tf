# Elastic IP for public-ec2-0
resource "aws_eip" "public_ec2_0" {
  instance = aws_instance.public_ec2_0.id
  domain = "vpc"
  
  tags = {
    Name = "eip-public-ec2-0"
  }
}

# Elastic IP for public-ec2-1
resource "aws_eip" "public_ec2_1" {
  instance = aws_instance.public_ec2_1.id
  domain = "vpc"
  
  tags = {
    Name = "eip-public-ec2-1"
  }
}