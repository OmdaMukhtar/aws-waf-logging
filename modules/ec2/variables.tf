variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
  default = "kali"
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet" {
  type = string
}