variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}



variable "tags" {
  description = "Tags for the day26terraform project"
  type        = map(string)
  default = {
    Name        = "day26terraform"
    Environment = "Development"
    Project     = "TerraformProject"
  }
}

/*
variable "vpc_id" {
  description = "The ID of the VPC to which the subnets will be attached"
  type        = string
}
*/