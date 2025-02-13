resource "aws_autoscaling_group" "asg" {
  name = "asg"

  vpc_zone_identifier = aws_subnet.private_for_ec2.*.id
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4

  launch_template {
    id      = aws_launch_template.asg_lt.id
    version = "$Default"
  }

  target_group_arns         = [aws_lb_target_group.alb_asg_tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "private-ec2-${var.vpc_name}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "asg_policy"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 7.0
  }
}
