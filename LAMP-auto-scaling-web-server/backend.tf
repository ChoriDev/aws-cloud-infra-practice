terraform {
  backend "s3" {
    bucket         = "aws-cloud-infra-practice-tfstate"
    key            = "workspace/LAMP-auto-scaling-web-server/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
