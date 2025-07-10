output "security_group_id" {
  value = [module.security_group.security_group_id]
}

output "asg_security_group_id" {
  value = [module.asg_web_server_sg.security_group_id]
}


output "bastion_security_group_id" {
  value = [module.bastion_sg.security_group_id]
}

