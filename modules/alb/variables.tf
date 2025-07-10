variable "project_name" {
  type    = string
  default = "demo-project"
}

variable "public_subnets" {
  type = list(string)
}

variable "vpc_cidr_block" {
  type = string
}

variable "vpc_id" {
  type = string
}
