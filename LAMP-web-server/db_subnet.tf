resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-subnet-group"
  description = "Subnet group for rds-subnet-group"
  subnet_ids  = aws_subnet.private_for_rds.*.id

  tags = {
    Name = "rds-subnet-group"
  }
}
