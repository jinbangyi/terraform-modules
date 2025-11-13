variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "terraform-module"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default = {
    "Terraform"   = "true"
    "ManagedBy"   = "Terraform"
    "Environment" = "dev"
  }
}

# Cloud Provider Selection
variable "enable_aws" {
  description = "Enable AWS resources"
  type        = bool
  default     = false
}

variable "enable_huaweicloud" {
  description = "Enable Huawei Cloud resources"
  type        = bool
  default     = false
}

# AWS Configuration
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "aws_vpc_cidr" {
  description = "CIDR block for AWS VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_public_subnet_cidrs" {
  description = "List of CIDR blocks for AWS public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "aws_private_subnet_cidrs" {
  description = "List of CIDR blocks for AWS private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "aws_instance_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "aws_create_instance" {
  description = "Whether to create AWS EC2 instance"
  type        = bool
  default     = false
}

# Huawei Cloud Configuration
variable "huaweicloud_region" {
  description = "Huawei Cloud region"
  type        = string
  default     = "cn-north-4"
}

variable "huaweicloud_vpc_cidr" {
  description = "CIDR block for Huawei Cloud VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "huaweicloud_public_subnet_cidrs" {
  description = "List of CIDR blocks for Huawei Cloud public subnets"
  type        = list(string)
  default     = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "huaweicloud_private_subnet_cidrs" {
  description = "List of CIDR blocks for Huawei Cloud private subnets"
  type        = list(string)
  default     = ["192.168.10.0/24", "192.168.20.0/24"]
}

variable "huaweicloud_flavor" {
  description = "Huawei Cloud ECS instance flavor"
  type        = string
  default     = "s6.small.1"
}

variable "huaweicloud_create_instance" {
  description = "Whether to create Huawei Cloud ECS instance"
  type        = bool
  default     = false
}