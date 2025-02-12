/*
# Target group for public ec2 instances
resource "aws_lb_target_group" "alb_public_tg" {
  name = "alb-public-tg-${var.vpc_name}"
  vpc_id = aws_vpc.main.id
  target_type = "instance"
  port = 80
  protocol = "HTTP"
  protocol_version = "HTTP1"

  health_check {
    protocol = "HTTP"
    path = "/"
    enabled = true
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
    matcher = "200"
  }

  tags = {
    Name = "alb-public-tf-${var.vpc_name}"
  }
}

# Register public ec2 instances with Target group
resource "aws_lb_target_group_attachment" "public_ec2" {
  for_each = {
    for k, v in aws_instance.public_ec2 : k => v # type casting: list to map
  }

  target_group_arn = aws_lb_target_group.alb_public_tg.arn
  target_id = each.value.id
  port = 80
}
*/

# Target group for private ec2 instances
resource "aws_lb_target_group" "alb_private_tg" {
  name             = "alb-private-tg-${var.vpc_name}"
  vpc_id           = aws_vpc.main.id
  target_type      = "instance"
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    enabled             = true
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "alb-private-tf-${var.vpc_name}"
  }
}

# Register private ec2 instances with Target group
resource "aws_lb_target_group_attachment" "private_ec2" {
  for_each = {
    for k, v in aws_instance.private_ec2 : k => v # type casting: list to map 
  }

  target_group_arn = aws_lb_target_group.alb_private_tg.arn
  target_id        = each.value.id
  port             = 80
}
