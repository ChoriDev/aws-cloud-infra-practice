variable "vpc_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "cidr_numeral_public" {
  type = list(number) 
}

variable "cidr_numeral_private" {
  type = list(number)
}