# Target group
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

# Register targets with Target group
resource "aws_lb_target_group_attachment" "public_ec2" {
  for_each = {
    for k, v in aws_instance.public_ec2 : k => v # type casting: list to map
  }

  target_group_arn = aws_lb_target_group.alb_public_tg.arn
  target_id = each.value.id
  port = 80
}