
output "frontend_elb_dns" {
  description = "The DNS name of the frontend ELB"
  value       = module.elb.elb_dns_name
}

