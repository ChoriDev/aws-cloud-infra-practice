# S3 Bucket for Backend
resource "aws_s3_bucket" "tfstate" {
  bucket = "aws-cloud-infra-practice-tfstate"
}

resource "aws_s3_bucket_versioning" "versioning_tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}