# Security group for public ec2
resource "aws_security_group" "public_ec2_sg" {
  name        = "public-ec2-sg"
  description = "Security group for public ec2 instance"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "public-ec2-sg"
  }
}

# Inbound rule allowing SSH for public ec2
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_for_public_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Inbound rule allowing HTTP for public ec2
resource "aws_vpc_security_group_ingress_rule" "allow_http_for_public_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Inbound rule allowing HTTPS for public ec2
resource "aws_vpc_security_group_ingress_rule" "allow_https_for_public_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Outbound rule allowing all traffic for public ec2
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_public_ec2" {
  security_group_id = aws_security_group.public_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security group for private ec2
resource "aws_security_group" "private_ec2_sg" {
  name        = "private-ec2-sg"
  description = "Security group for private ec2 instance"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private-ec2-sg"
  }
}

# Inbound rule allowing SSH for private ec2
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_for_private_ec2" {
  security_group_id = aws_security_group.private_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Inbound rule allowing HTTP for private ec2
resource "aws_vpc_security_group_ingress_rule" "allow_http_for_private_ec2" {
  security_group_id = aws_security_group.private_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Inbound rule allowing HTTPS for private ec2
resource "aws_vpc_security_group_ingress_rule" "allow_https_for_private_ec2" {
  security_group_id = aws_security_group.private_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Outbound rule allowing all traffic for private ec2
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_private_ec2" {
  security_group_id = aws_security_group.private_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security group for EFS
resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Security group for efs"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "efs-sg"
  }
}

# Inbound rule allowing NFS for EFS
resource "aws_vpc_security_group_ingress_rule" "allow_nfs_for_efs" {
  security_group_id = aws_security_group.efs_sg.id
  # Fill in below value with security group whose instance will connect to EFS
  referenced_security_group_id = aws_security_group.public_ec2_sg.id
  from_port                    = 2049
  ip_protocol                  = "tcp"
  to_port                      = 2049
}

# Outbound rule allowing all traffic for EFS
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_efs" {
  security_group_id = aws_security_group.efs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security group for public ALB
resource "aws_security_group" "alb_public_sg" {
  name        = "alb-public-sg"
  description = "Security group for public alb"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "alb-public-sg"
  }
}

# Inbound rule allowing HTTP for public ALB
resource "aws_vpc_security_group_ingress_rule" "allow_http_for_public_alb" {
  security_group_id = aws_security_group.alb_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Outbound rule allowing all traffic for public ALB
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_public_alb" {
  security_group_id = aws_security_group.alb_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security group for private ALB
resource "aws_security_group" "alb_private_sg" {
  name        = "alb-private-sg"
  description = "Secutiry group for private alb"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "alb-private-sg"
  }
}

# Inbound rule allowing HTTP for private ALB
resource "aws_vpc_security_group_ingress_rule" "allow_http_for_private_alb" {
  security_group_id = aws_security_group.alb_private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Outbound rule allowing all traffic for private ALB
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_private_alb" {
  security_group_id = aws_security_group.alb_private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "rds-sg"
  }
}

# Inbound rule allowing MySQL for RDS
resource "aws_vpc_security_group_ingress_rule" "allow_mysql_for_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = "3306"
  ip_protocol       = "tcp"
  to_port           = "3306"
}

# Outbound rule allowing all traffic for RDS
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_traffic_for_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
