variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
}


variable "vpc_id" {
    description = "The ID of the VPC where the ELB will be created"
    type        = string
}

variable "image_id" {
  description = "Image id"
  default = "ami-0ebfd941bbafe70c6"
}

# Declare the variable for the ELB security group ID
variable "elb_security_group_id" {
  description = "The security group ID associated with the ELB"
  type        = string
}
