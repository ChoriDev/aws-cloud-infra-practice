resource "aws_s3_bucket" "main" {
  bucket = "s3-web-hosting-chori"

  tags = {
    Name = "s3-web-hosting-chori"
  }
}

resource "aws_s3_bucket_website_configuration" "web_hosting" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = "mycar.html"
  }
}