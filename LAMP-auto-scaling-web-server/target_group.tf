# Target group for Auto Scaling Group's EC2 instances
resource "aws_lb_target_group" "alb_asg_tg" {
  name             = "alb-asg-tg-${var.vpc_name}"
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
    Name = "alb-asg-tg-${var.vpc_name}"
  }
}
