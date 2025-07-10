 locals {
  name = "${var.project_name}-autoscaling"
}

module "asg" {
  source =  "terraform-aws-modules/autoscaling/aws"
  # version = "7.4.1"

  # Autoscaling group
  name            = "${var.project_name}-autoscaling"
  min_size                  = 0
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = "0"
  default_instance_warmup   = 300
  health_check_type         = "ELB"
  vpc_zone_identifier       = var.private_subnets


  # Launch Template
  launch_template_name        = "${var.project_name}-launch-template"
  launch_template_description = "${var.project_name} Complete launch template example"
  update_default_version      = true
  key_name = var.key_name 
  image_id          = data.aws_ami.this.id
  instance_type     = var.instance_type
  user_data = base64encode(file("${path.root}/scripts/user_data.sh"))

  security_groups = var.asg_security_group_id
  # target_group_arns = var.aws_lb_target_group
  # target_group_arns = [aws_lb_target_group.webserver_target_groups.arn]
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
 
