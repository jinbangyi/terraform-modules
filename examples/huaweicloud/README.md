# Huawei Cloud-only Example

This example demonstrates how to use the multi-cloud Terraform module to deploy resources only on Huawei Cloud.

## Prerequisites

- Huawei Cloud CLI configured with appropriate credentials
- Terraform >= 1.0

## Usage

```bash
# Change to the example directory
cd examples/huaweicloud

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## What this example creates

- Huawei Cloud VPC with public and private subnets
- Security Group with SSH, HTTP, and HTTPS access
- ECS instance (CentOS 7.6)

## Configuration

The example deploys resources in the `cn-north-4` region with:
- VPC CIDR: 192.168.0.0/16
- 2 public subnets: 192.168.1.0/24, 192.168.2.0/24
- 2 private subnets: 192.168.10.0/24, 192.168.20.0/24
- ECS instance flavor: s6.small.1

## Clean up

```bash
# Destroy the created resources
terraform destroy
```