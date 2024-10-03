provider "aws" {
  #alias  = "region_1"
  region = "us-east-1"
}

#create vpc main/primary
resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"
  #provider   = aws.region_1
  tags = {
    Name = "vpc_main"
  }
}

/*
# Create VPC secondary in region_2
resource "aws_vpc" "vpc_secondary" {
  cidr_block = "10.2.0.0/16"
  provider   = aws.region_2
  tags = {
    Name = "vpc_secondary"
  }
}
*/

module "subnets" {
  source = "../../modules/subnets"
  vpc_id = aws_vpc.vpc_main.id
  #providers = {
  #  aws = aws.region_1 
  #}
}



module "dynamodb" {
  source = "../../modules/dynamodb"
}

module "ec2" {
  source        = "../../modules/ec2"
  instance_type = var.instance_type
  vpc_id        = aws_vpc.vpc_main.id
  elb_security_group_id = module.elb.elb_security_group_id
}

module "asg" {
  source             = "../../modules/asg"
  launch_template_id = module.ec2.launch_template_id
  subnet_ids = [
    module.subnets.private_subnet_A_id,
    module.subnets.private_subnet_B_id
  ]
  target_group_arn = module.elb.frontendTG
}

module "elb" {
  source = "../../modules/elb"
  vpc_id = aws_vpc.vpc_main.id
  subnet_ids = [
    module.subnets.public_subnet_A_id,
    module.subnets.public_subnet_B_id
  ]
  webserver_sg = module.ec2.webserver_sg
}
