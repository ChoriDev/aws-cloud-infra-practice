# AMI
# resource "aws_ami" "ami_public_ec2_main" {
#   name = "ami-public-ec2-main"
#   boot_mode = "uefi-preferred"
#   description = "ami of public ec2 instance"
#   ena_support = true
#   image_location = "908027406601/ami-public-ec2-main"
#   imds_support = "v2.0"
#   root_device_name = "/dev/sda1"
#   virtualization_type = "hvm"

#   ebs_block_device {
#     delete_on_termination = true
#     device_name = "/dev/sda1"
#     encrypted = false
#     iops = 3000
#     snapshot_id = "snap-0b14d206dc33b052b" # EBS snapshot
#     throughput = 125
#     volume_size = 8
#     volume_type = "gp3"
#   }

#   ephemeral_block_device {
#     device_name  = "/dev/sdb"
#     virtual_name = "ephemeral0"
#   }

#   ephemeral_block_device {
#     device_name  = "/dev/sdc"
#     virtual_name = "ephemeral1"
#   }

#   tags = {
#     Name = "ami-public-ec2-main"
#   }
# }