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
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
  count  = var.enable_aws ? 1 : 0

  default_tags {
    tags = var.tags
  }
}

# Configure Huawei Cloud Provider
provider "huaweicloud" {
  region = var.huaweicloud_region
  count  = var.enable_huaweicloud ? 1 : 0
}

# Example local file for demonstration
resource "local_file" "example" {
  content  = "Multi-cloud Terraform module: ${var.name}"
  filename = "${path.module}/example.txt"
}

# AWS Resources (conditional creation)
module "aws_resources" {
  count   = var.enable_aws ? 1 : 0
  source  = "./modules/aws"

  name_prefix  = var.name
  environment  = var.environment
  vpc_cidr     = var.aws_vpc_cidr
  public_cidrs = var.aws_public_subnet_cidrs
  private_cidrs = var.aws_private_subnet_cidrs
  instance_type = var.aws_instance_type
  tags         = var.tags

  depends_on = [local_file.example]
}

# Huawei Cloud Resources (conditional creation)
module "huaweicloud_resources" {
  count   = var.enable_huaweicloud ? 1 : 0
  source  = "./modules/huaweicloud"

  name_prefix  = var.name
  environment  = var.environment
  vpc_cidr     = var.huaweicloud_vpc_cidr
  public_cidrs = var.huaweicloud_public_subnet_cidrs
  private_cidrs = var.huaweicloud_private_subnet_cidrs
  flavor       = var.huaweicloud_flavor
  tags         = var.tags

  depends_on = [local_file.example]
}