variable "vpc_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "cidr_numeral_public_ec2" {
  type = list(number)
}

variable "cidr_numeral_private_ec2" {
  type = list(number)
}

variable "cidr_numeral_private_rds" {
  type = list(number)
}
