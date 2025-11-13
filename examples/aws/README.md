# AWS-only Example

This example demonstrates how to use the multi-cloud Terraform module to deploy resources only on AWS.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0

## Usage

```bash
# Change to the example directory
cd examples/aws

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## What this example creates

- AWS VPC with public and private subnets
- Internet Gateway and route tables
- Security Group with SSH, HTTP, and HTTPS access
- EC2 instance (Amazon Linux 2)

## Configuration

The example deploys resources in the `us-west-2` region with:
- VPC CIDR: 10.100.0.0/16
- 2 public subnets: 10.100.1.0/24, 10.100.2.0/24
- 2 private subnets: 10.100.10.0/24, 10.100.20.0/24
- EC2 instance type: t3.micro

## Clean up

```bash
# Destroy the created resources
terraform destroy
```