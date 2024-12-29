resource "aws_instance" "public" {
  ami = "ami-0dc44556af6f78a7b" # Ubuntu Server 24.04 LTS (HVM), x86
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2_key_pair.key_name
  vpc_security_group_ids = [ aws_security_group.public_ec2_sg.id ]
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "public-ec2-0-${var.vpc_name}"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 1
    http_tokens = "optional"
    instance_metadata_tags = "enabled"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get upgrade -y
    apt-get install -y apache2 mariadb-server php libapache2-mod-php php-mysql
    systemctl start apache2
    systemctl enable apache2
    systemctl start mysql
    systemctl enable mysql
    usermod -a -G www-data ubuntu
    chown -R ubuntu:www-data /var/www/html
    chmod 2775 /var/www/html
    find /var/www/html -type d -exec chmod 2775 {} \;
    find /var/www/html -type f -exec chmod 0664 {} \;
    echo "<?php phpinfo(); ?>" > /var/www/html/index.php
  EOF
}