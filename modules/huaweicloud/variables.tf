variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "private_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["192.168.10.0/24", "192.168.20.0/24"]
}

variable "flavor" {
  description = "ECS instance flavor"
  type        = string
  default     = "s6.small.1"
}

variable "create_instance" {
  description = "Whether to create ECS instance"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}