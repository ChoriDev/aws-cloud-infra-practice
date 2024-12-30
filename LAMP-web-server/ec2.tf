# Public-ec2
resource "aws_instance" "public_ec2" {
  count = length(var.cidr_numeral_public)
  ami = "ami-049788618f07e189d" # Amazon Linux 2023, x86
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2_key_pair.key_name
  vpc_security_group_ids = [ aws_security_group.public_ec2_sg.id ]
  subnet_id = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "public-ec2-${count.index}-${var.vpc_name}"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 1
    http_tokens = "optional"
    instance_metadata_tags = "enabled"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
    yum install -y httpd mariadb-server
    systemctl start httpd
    systemctl enable httpd
    usermod -a -G apache ec2-user
    chown -R ec2-user:apache /var/www
    chmod 2775 /var/www
    find /var/www -type d -exec chmod 2775 {} \;
    find /var/www -type f -exec chmod 0664 {} \;
  EOF
}