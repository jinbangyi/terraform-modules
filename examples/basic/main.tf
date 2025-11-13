# Basic usage example of the Terraform module
# This example demonstrates how to use the module with default settings

terraform {
  required_version = ">= 1.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Example 1: Basic usage with default values
module "example_basic" {
  source = "../../"

  # Using default values
}

# Example 2: Custom configuration
module "example_custom" {
  source = "../../"

  name        = "custom-resource"
  environment = "production"

  tags = {
    "Project"    = "my-project"
    "Owner"      = "devops@example.com"
    "Environment" = "production"
    "CostCenter" = "engineering"
  }
}

# Example 3: Using variables
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "example-project"
}

variable "environment_name" {
  description = "Target environment"
  type        = string
  default     = "staging"
}

module "example_variables" {
  source = "../../"

  name        = var.project_name
  environment = var.environment_name

  tags = {
    "Project"     = var.project_name
    "Environment" = var.environment_name
    "ManagedBy"   = "Terraform"
  }
}