resource "aws_s3_bucket" "main" {
  bucket = "s3-web-hosting-chori"

  tags = {
    Name = "s3-web-hosting-chori"
  }
}