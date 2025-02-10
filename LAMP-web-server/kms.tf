data "aws_caller_identity" "current" {}

resource "aws_kms_key" "rds_password_key" {
  description             = "KMS key for encrypting RDS password"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  rotation_period_in_days = 90
}

resource "aws_kms_key_policy" "rds_password_key_policy" {
  key_id = aws_kms_key.rds_password_key.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "rds_password_key" {
  name          = "alias/rds-password-key"
  target_key_id = aws_kms_key.rds_password_key.key_id
}
