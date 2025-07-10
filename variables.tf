variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "key_name" {
  description = "Name of the existing EC2 Key Pair"
  default = "kali"
}
