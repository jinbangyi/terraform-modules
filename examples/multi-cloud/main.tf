# Multi-cloud deployment example
# This example demonstrates how to use the module to deploy resources on both AWS and Huawei Cloud

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.50"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-west-2"
}

# Configure Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-4"
}

# Use the multi-cloud module with both providers enabled
module "multi_cloud_infrastructure" {
  source = "../../"

  name        = "multi-cloud-example"
  environment = "production"

  # Enable both cloud providers
  enable_aws = true
  enable_huaweicloud = true

  # AWS Configuration
  aws_region = "us-west-2"
  aws_vpc_cidr = "10.100.0.0/16"
  aws_public_subnet_cidrs = ["10.100.1.0/24", "10.100.2.0/24"]
  aws_private_subnet_cidrs = ["10.100.10.0/24", "10.100.20.0/24"]
  aws_instance_type = "t3.micro"
  aws_create_instance = true

  # Huawei Cloud Configuration
  huaweicloud_region = "cn-north-4"
  huaweicloud_vpc_cidr = "192.168.0.0/16"
  huaweicloud_public_subnet_cidrs = ["192.168.1.0/24", "192.168.2.0/24"]
  huaweicloud_private_subnet_cidrs = ["192.168.10.0/24", "192.168.20.0/24"]
  huaweicloud_flavor = "s6.small.1"
  huaweicloud_create_instance = true

  tags = {
    "Project"     = "multi-cloud-example"
    "Owner"       = "devops@example.com"
    "Environment" = "production"
    "CostCenter"  = "engineering"
    "ManagedBy"   = "Terraform"
  }
}