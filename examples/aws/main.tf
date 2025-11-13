# AWS-only deployment example
# This example demonstrates how to use the module to deploy resources only on AWS

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-west-2"
}

# Use the multi-cloud module with AWS enabled
module "aws_infrastructure" {
  source = "../../"

  name        = "aws-example"
  environment = "production"

  # Enable AWS resources
  enable_aws = true
  enable_huaweicloud = false

  # AWS Configuration
  aws_region = "us-west-2"
  aws_vpc_cidr = "10.100.0.0/16"
  aws_public_subnet_cidrs = ["10.100.1.0/24", "10.100.2.0/24"]
  aws_private_subnet_cidrs = ["10.100.10.0/24", "10.100.20.0/24"]
  aws_instance_type = "t3.micro"
  aws_create_instance = true

  tags = {
    "Project"     = "aws-example"
    "Owner"       = "devops@example.com"
    "Environment" = "production"
    "CostCenter"  = "engineering"
    "Cloud"       = "AWS"
  }
}