data "external" "sops_secret" {
  program = ["sh", "-c", "sops -d terraform.enc.json | jq -r '{secret: .secret}'"]
}

resource "aws_db_instance" "rds" {
  identifier                      = "rds"
  db_name                         = "vpcrds"
  instance_class                  = "db.t3.micro"
  storage_type                    = "gp2"
  allocated_storage               = 20
  max_allocated_storage           = 0
  engine                          = "mysql"
  engine_version                  = "8.0"
  auto_minor_version_upgrade      = true
  username                        = "admin"
  password                        = data.external.sops_secret.result["secret"]
  multi_az                        = true
  db_subnet_group_name            = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]
  publicly_accessible             = false
  parameter_group_name            = "default.mysql8.0"
  backup_retention_period         = 7
  copy_tags_to_snapshot           = true
  enabled_cloudwatch_logs_exports = ["general"]
  deletion_protection             = false
  skip_final_snapshot             = true
}
