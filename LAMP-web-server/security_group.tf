# Security group for public ec2
resource "aws_security_group" "public_ec2_sg" {
  name = "public-ec2-sg"
  description = "Security group for public ec2 instance"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-ec2-sg"
  }
}

# Inbound rule allowing SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

# Inbound rule allowing HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

# Inbound rule allowing HTTPS
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  ip_protocol = "tcp"
  to_port = 443
}