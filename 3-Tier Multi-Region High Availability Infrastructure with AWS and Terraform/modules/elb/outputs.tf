output "elb_dns_name" {
  description = "The DNS name of the frontend load balancer"
  value       = aws_lb.frontend_lb.dns_name
}

output "frontendTG" {
  value = aws_lb_target_group.frontendTG.arn 
}

# Output the ELB Security Group ID
output "elb_security_group_id" {
  value       = aws_security_group.web_elb_sg.id
  description = "The security group ID associated with the ELB"
}
