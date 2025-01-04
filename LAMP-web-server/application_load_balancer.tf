resource "aws_lb" "alb_public" {
  name = "alb-public"
  load_balancer_type = "application"
  internal = false
  ip_address_type = "ipv4"
  security_groups = [aws_security_group.alb_public_sg.id]
  
  # Indicate which subnet in the availability zone will receive traffic
  dynamic "subnet_mapping" {
    for_each = toset(aws_subnet.public_for_ec2)
    content {
      subnet_id = subnet_mapping.value.id
    }
  }
}

resource "aws_lb_listener" "alb_public_listener" {
  load_balancer_arn = aws_lb.alb_public.arn
  port = 80
  protocol = "HTTP"
  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_public_tg.arn
  }

  tags = {
    Name = "alb-public"
  }
}