resource "aws_lb" "alb_asg" {
  name               = "alb-asg"
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.alb_asg_sg.id]

  # Indicate which subnet in the availability zone will receive traffic
  dynamic "subnet_mapping" {
    for_each = toset(aws_subnet.public_for_ec2)
    content {
      subnet_id = subnet_mapping.value.id
    }
  }
}

resource "aws_lb_listener" "alb_as_listener" {
  load_balancer_arn = aws_lb.alb_asg.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_asg_tg.arn
  }

  tags = {
    Name = "alb-asg"
  }
}
