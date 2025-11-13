# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Rules for Claude

- should read the files in docs/general/overview first, which are the index files of the repo

## Repository Overview

This is a multi-cloud Terraform modules repository supporting AWS and Huawei Cloud infrastructure deployment. The architecture uses conditional resource creation to enable single-cloud or multi-cloud deployments from a single codebase.

## Key Architecture

### Module Structure
- **Root module**: Controls provider configuration and orchestrates cloud-specific modules
- **modules/aws/**: AWS-specific resources (VPC, subnets, EC2, security groups)
- **modules/huaweicloud/**: Huawei Cloud-specific resources (VPC, subnets, ECS, security groups)
- **modules/s3/**: S3 bucket access module for creating IAM users with prefix-restricted access

### Conditional Resource Pattern
The root module uses `count = var.enable_aws ? 1 : 0` and `count = var.enable_huaweicloud ? 1 : 0` to conditionally create cloud resources. Providers are also conditionally configured to avoid authentication errors for unused clouds.

### Output Handling
Outputs use conditional expressions with `try()` to safely access module outputs that may not exist when a cloud provider is disabled.

## Common Development Commands

### Terraform Operations
```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt -check

# Plan deployment (with specific var file)
terraform plan -var-file="examples/aws/terraform.tfvars"

# Apply configuration
terraform apply

# Destroy resources
terraform destroy
```

### Testing Examples
```bash
# Test specific example configurations
cd examples/aws && terraform init && terraform validate
cd examples/huaweicloud && terraform init && terraform validate
cd examples/multi-cloud && terraform init && terraform validate
cd examples/s3 && terraform init && terraform validate
```

### Documentation Generation
```bash
# Generate README from Terraform code
terraform-docs markdown . > README.md
```

## Development Standards

### File Organization
- `main.tf`: Provider configuration and module orchestration
- `variables.tf`: All input variables with descriptions
- `outputs.tf`: Output values with conditional handling
- `examples/`: Self-contained deployment scenarios
- `docs/`: Additional documentation and AI-generated summaries

### Coding Standards
- Use consistent naming: `${var.name_prefix}-${resource}-${var.environment}`
- All variables require descriptions
- Use `merge()` for combining tags with resource-specific tags
- Implement conditional resource creation for multi-cloud support
- Use `try()` for accessing optional module outputs

### Environment Rules
- Temporary content goes in `debug/` directory
- AI implementation summaries in `docs/AI/summaries/`

## Module Dependencies

### Provider Requirements
- Terraform >= 1.0
- AWS provider ~> 5.0
- Huawei Cloud provider ~> 1.50
- Local provider ~> 2.0
- Random provider ~> 3.0 (for S3 module)

### Module Inputs
Key variables control deployment behavior:
- `enable_aws` / `enable_huaweicloud`: Control cloud provider activation
- Cloud-specific CIDR blocks for VPC and subnets
- Instance types/flavors for compute resources
- Tagging strategy via `var.tags`

## Authentication Setup

### AWS
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-west-2"
```

### Huawei Cloud
```bash
export HUAWEICLOUD_ACCESS_KEY="your-access-key"
export HUAWEICLOUD_SECRET_KEY="your-secret-key"
export HUAWEICLOUD_PROJECT_NAME="your-project-name"
```

## Multi-Cloud Deployment Patterns

### Single-Cloud Deployment
Set only one of `enable_aws` or `enable_huaweicloud` to `true`

### Multi-Cloud Deployment
Set both `enable_aws` and `enable_huaweicloud` to `true`

### S3 Access Module
The S3 module is independent and can be used with or without the main infrastructure modules. It creates IAM users with restricted access to existing S3 buckets at the prefix level.
