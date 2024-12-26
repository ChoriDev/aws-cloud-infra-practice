resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.main.id
  key = "mycar.html"
  source = "./mycar.html"
}

resource "aws_s3_object" "car_image" {
  bucket = aws_s3_bucket.main.id
  key = "car.jpg"
  source = "./car.jpg"
}