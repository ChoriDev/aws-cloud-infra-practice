# EFS
resource "aws_efs_file_system" "main" {
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  tags = {
    Name = "efs-${var.vpc_name}"
  }
}

# EFS backup policy
resource "aws_efs_backup_policy" "efs_backup_policy" {
  file_system_id = aws_efs_file_system.main.id

  backup_policy {
    status = "DISABLED"
  }
}

# EFS mount target
resource "aws_efs_mount_target" "public_subnet" {
  count           = length(var.availability_zones)
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = element(aws_subnet.public_for_ec2.*.id, count.index)
  security_groups = [aws_security_group.efs_sg.id]
}
