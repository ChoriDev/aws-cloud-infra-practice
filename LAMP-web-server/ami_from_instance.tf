resource "aws_ami_from_instance" "public_ec2_ami" {
  depends_on = [terraform_data.copy_index]
  
  name = "public-ec2-ami"
  source_instance_id = aws_instance.public_ec2.*.id[0]
  snapshot_without_reboot = false
}