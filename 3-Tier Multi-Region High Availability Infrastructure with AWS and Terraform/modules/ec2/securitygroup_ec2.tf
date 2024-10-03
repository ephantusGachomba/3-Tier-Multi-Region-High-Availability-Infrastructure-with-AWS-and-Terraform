#1. Web Server Security Group (webserver_sg):
#Allows traffic from the Web ELB(80)
resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "allow traffic from port 80 & allow all outgoing traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "webserver_sg"
  }
}


# Inbound rule for HTTP traffic from the Web ELB (port 80)
resource "aws_security_group_rule" "allow_tcp_web_80" {
  type                     = "ingress"
  security_group_id         = aws_security_group.webserver_sg.id
  from_port                 = 80
  to_port                   = 80
  protocol                  = "tcp"
  description               = "Allow HTTP from Web ELB"
  source_security_group_id  = var.elb_security_group_id
}

# Inbound rule for HTTPS traffic from the Web ELB (port 443)
resource "aws_security_group_rule" "allow_tcp_web_443" {
  type                     = "ingress"
  security_group_id         = aws_security_group.webserver_sg.id
  from_port                 = 443
  to_port                   = 443
  protocol                  = "tcp"
  description               = "Allow HTTPS from Web ELB"
  source_security_group_id  = var.elb_security_group_id
}



# Allow all outbound traffic to internet(http)
resource "aws_security_group_rule" "allow_outbound_http" {
  type              = "egress"
  security_group_id = aws_security_group.webserver_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic to internet"
}
