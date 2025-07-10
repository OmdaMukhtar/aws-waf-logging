# Import VPC
module "vpc" {
  source = "./modules/vpc"
}

# Import Security Groups
module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "id_rsa"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Import Application Loadbalancer (must be created before ASG)
module "alb" {
  source         = "./modules/alb"
  public_subnets = module.vpc.public_subnets
  vpc_cidr_block = module.vpc.vpc_cidr_block
  vpc_id         = module.vpc.vpc_id
}

# Import Auto Scaling Groups (now it can reference the ALB's target groups)
module "autoscaling" {
  source                = "./modules/asg"
  vpc_id                = module.vpc.vpc_id
  vpc_cidr_block        = module.vpc.vpc_cidr_block
  private_subnets       = module.vpc.private_subnets
  key_name              = "id_rsa"
  asg_security_group_id = module.security_groups.asg_security_group_id
}

# EC2 Instance For debuging the infra
module "compute" {
  source             = "./modules/ec2"
  subnet             = module.vpc.public_subnets[0]
  key_name           = "id_rsa"
  security_group_ids = module.security_groups.bastion_security_group_id
}
