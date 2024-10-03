#to be used  in asg
output "launch_template_id" {
  value = aws_launch_template.frontend.id
}

output "webserver_sg" {
  value = aws_security_group.webserver_sg.id 
}