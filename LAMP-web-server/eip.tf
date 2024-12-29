# Elastic IP for public-ec2-0
resource "aws_eip" "public" {
  instance = aws_instance.public.id
  domain = "vpc"
  
  tags = {
    Name = "eip-public-ec2"
  }
}