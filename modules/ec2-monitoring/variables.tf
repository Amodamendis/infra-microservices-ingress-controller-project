variable "subnet_id" {
  description = "The ID of the subnet to deploy the instance into"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach"
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.medium"
}