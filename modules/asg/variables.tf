variable "project_name" {
  type = string
  default = "demo-project"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
  default = "kali"
}

variable "vpc_cidr_block" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "asg_security_group_id" {
  type = list(string)
}
