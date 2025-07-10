locals {
  name = "project-demo-alb"
  tags = {
    Name = "project-demo-alb"
  }
}

module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "${var.project_name}-alb"
  vpc_id  = var.vpc_id
  subnets = var.public_subnets

  # For testing purpose/enviroment 
  enable_deletion_protection = false

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = var.vpc_cidr_block
    }
  }

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "webserver_target_groups"
      }
    }
  }

  target_groups = {
    webserver_target_groups = {
      backend_protocol                  = "HTTP"
      backend_port                      = "80"
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = true
      create_attachment                 = false # I will attach EC2s via Auto Scaling
    }
  }

  tags = local.tags
}
