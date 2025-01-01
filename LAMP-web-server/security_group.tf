# Security group for public ec2
resource "aws_security_group" "public_ec2_sg" {
  name = "public-ec2-sg"
  description = "Security group for public ec2 instance"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-ec2-sg"
  }
}

# Inbound rule allowing SSH for ec2
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_for_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

# Inbound rule allowing HTTP for ec2
resource "aws_vpc_security_group_ingress_rule" "allow_http_for_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

# Inbound rule allowing HTTPS for ec2
resource "aws_vpc_security_group_ingress_rule" "allow_https_for_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  ip_protocol = "tcp"
  to_port = 443
}

# Outbound rule allowing all traffic for ec2
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Security group for EFS
resource "aws_security_group" "efs_sg" {
  name = "efs-sg"
  description = "Security group for efs"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "efs-sg"
  }
}

# Inbound rule allowing NFS for EFS
resource "aws_vpc_security_group_ingress_rule" "allow_nfs_for_efs" {
  security_group_id = aws_security_group.efs_sg.id
  # Fill in below value with security group whose instance will connect to EFS
  referenced_security_group_id = aws_security_group.public_ec2_sg.id
  from_port = 2049
  ip_protocol = "tcp"
  to_port = 2049
}

# Outbound rule allowing all traffic for EFS
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_efs" {
  security_group_id = aws_security_group.efs_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}