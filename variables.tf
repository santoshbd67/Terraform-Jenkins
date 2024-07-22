variable "region" {
  description = "AWS region for the resources."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
}

variable "azs" {
  description = "Availability zones."
  type        = list(string)
}

variable "public_instance_ami" {
  description = "AMI ID for the public instance."
  type        = string
}

variable "private_instance_ami" {
  description = "AMI ID for the private instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}
