# Huawei Cloud-only deployment example
# This example demonstrates how to use the module to deploy resources only on Huawei Cloud

terraform {
  required_version = ">= 1.0"
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.50"
    }
  }
}

# Configure Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-4"
}

# Use the multi-cloud module with Huawei Cloud enabled
module "huaweicloud_infrastructure" {
  source = "../../"

  name        = "huaweicloud-example"
  environment = "production"

  # Enable Huawei Cloud resources
  enable_aws = false
  enable_huaweicloud = true

  # Huawei Cloud Configuration
  huaweicloud_region = "cn-north-4"
  huaweicloud_vpc_cidr = "192.168.0.0/16"
  huaweicloud_public_subnet_cidrs = ["192.168.1.0/24", "192.168.2.0/24"]
  huaweicloud_private_subnet_cidrs = ["192.168.10.0/24", "192.168.20.0/24"]
  huaweicloud_flavor = "s6.small.1"
  huaweicloud_create_instance = true

  tags = {
    "Project"     = "huaweicloud-example"
    "Owner"       = "devops@example.com"
    "Environment" = "production"
    "CostCenter"  = "engineering"
    "Cloud"       = "HuaweiCloud"
  }
}