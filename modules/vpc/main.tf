locals {
    name      = "demo-project-vpc"
    vpc_cidr  = "172.31.0.0/16"
    azs       = ["us-east-1a", "us-east-1b"]
    tags = {
        Project = "demo-project"
        OwnedBy = "DevOps"
        Name    = "project-demo-vpc"
    }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  

  name = local.name
  cidr = local.vpc_cidr

  azs                 = local.azs
  private_subnets     = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
#   database_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 8)]
#   elasticache_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 12)]
#   redshift_subnets    = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 16)]
#   intra_subnets       = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 20)]

  private_subnet_names = ["private-subnet-1", "private-subnet-2"]
  public_subnet_names  = ["public-subnet-1", "public-subnet-2"]
  private_subnet_tags = {
    Name = "private-subnet"
  }

  public_subnet_tags = {
    Name = "public-subnet"
  }

  # public_subnet_names omitted to show default name generation for all three subnets
#   database_subnet_names    = ["DB Subnet One"]
#   elasticache_subnet_names = ["Elasticache Subnet One", "Elasticache Subnet Two"]
#   redshift_subnet_names    = ["Redshift Subnet One", "Redshift Subnet Two", "Redshift Subnet Three"]
#   intra_subnet_names       = []

  create_database_subnet_group  = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

# I  don't have private subnets so I'll disabled them.
  enable_nat_gateway = true
  single_nat_gateway = true

#   enable_vpn_gateway = true

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  vpc_flow_log_iam_role_name            = "vpc-complete-example-role"
  vpc_flow_log_iam_role_use_name_prefix = false
  enable_flow_log                       = true
  create_flow_log_cloudwatch_log_group  = true
  create_flow_log_cloudwatch_iam_role   = true
  flow_log_max_aggregation_interval     = 60

  tags = local.tags
}

