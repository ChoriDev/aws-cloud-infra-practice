resource "aws_launch_template" "asg_lt" {
  name                   = "asg_lt"
  description            = "Launch Template for Auto Scaling"
  image_id               = aws_ami_from_instance.public_ec2_ami.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.private_ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]
}
