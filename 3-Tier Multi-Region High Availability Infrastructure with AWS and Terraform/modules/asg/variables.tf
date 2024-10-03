variable "launch_template_id" {
    description = "The ID of the launch template to use for the ASG"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group for the ASG"
  type        = string
}
