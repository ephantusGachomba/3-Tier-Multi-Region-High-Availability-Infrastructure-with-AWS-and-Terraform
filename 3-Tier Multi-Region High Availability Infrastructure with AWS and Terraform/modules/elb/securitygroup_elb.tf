#. ELB Security Group for Web (web_elb_sg):
#Allows incoming traffic from the Internet
#Allows outbound traffic to the Web Servers.

resource "aws_security_group" "web_elb_sg" {
  name        = "web_elb_sg"
  description = "Allow traffic from the internet & allow all outgoing traffic to webservers"
  vpc_id      = var.vpc_id

  tags = {
    Name = "web_elb_sg"
  }
}

# allow Inbound rule traffic from internet(https)
resource "aws_security_group_rule" "allow_inbound_webelb_443" {
  type              = "ingress"
  security_group_id = aws_security_group.web_elb_sg.id
  from_port         = 443
  to_port           = 443
  protocol       = "TCP"
  cidr_blocks         = ["0.0.0.0/0"]
}

# allow Inbound rule traffic from internet(https)
resource "aws_security_group_rule" "allow_inbound_webelb_80" {
  type              = "ingress"
  security_group_id = aws_security_group.web_elb_sg.id
  from_port         = 80
  to_port           = 80
  protocol       = "TCP"
  cidr_blocks         = ["0.0.0.0/0"]
}



# Allow outbound traffic to web servers instances
resource "aws_security_group_rule" "allow_outbound_to_web_servers" {
  type              = "egress"
  security_group_id = aws_security_group.web_elb_sg.id
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id  = var.webserver_sg
}

resource "aws_security_group_rule" "allow_outbound_https_to_web_servers" {
  type                     = "egress"
  security_group_id         = aws_security_group.web_elb_sg.id
  from_port                 = 443
  to_port                   = 443
  protocol                  = "tcp"
  description               = "Allow outbound HTTPS traffic to web servers"
  source_security_group_id  = var.webserver_sg
}