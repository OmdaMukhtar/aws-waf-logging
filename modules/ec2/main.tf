module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "bastion-instance"

  instance_type = var.instance_type
  key_name      = var.key_name
  monitoring    = true
  subnet_id         = var.subnet
  
  ami = data.aws_ami.this.id
  # user_data       = file("${path.module}/scripts/user_data.sh")
  #user_data_base64 =   filebase64("${path.module}/scripts/user_data.sh")
  
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = true
  
  tags = {
    Terraform   = "true"
    Environment = "bastion"
  }
}

data "aws_ami" "this" {
  owners =["amazon"]
  most_recent = true

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name ="name"
    values = ["al2023-ami-2023*"]
  }
}
