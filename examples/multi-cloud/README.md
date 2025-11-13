# Multi-cloud Example

This example demonstrates how to use the multi-cloud Terraform module to deploy resources simultaneously on both AWS and Huawei Cloud.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Huawei Cloud CLI configured with appropriate credentials
- Terraform >= 1.0

## Usage

```bash
# Change to the example directory
cd examples/multi-cloud

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## What this example creates

### AWS Resources (us-west-2):
- VPC with public and private subnets
- Internet Gateway and route tables
- Security Group with SSH, HTTP, and HTTPS access
- EC2 instance (Amazon Linux 2)

### Huawei Cloud Resources (cn-north-4):
- VPC with public and private subnets
- Security Group with SSH, HTTP, and HTTPS access
- ECS instance (CentOS 7.6)

## Configuration

The example deploys resources with the following configurations:

### AWS:
- VPC CIDR: 10.100.0.0/16
- 2 public subnets: 10.100.1.0/24, 10.100.2.0/24
- 2 private subnets: 10.100.10.0/24, 10.100.20.0/24
- EC2 instance type: t3.micro

### Huawei Cloud:
- VPC CIDR: 192.168.0.0/16
- 2 public subnets: 192.168.1.0/24, 192.168.2.0/24
- 2 private subnets: 192.168.10.0/24, 192.168.20.0/24
- ECS instance flavor: s6.small.1

## Benefits of Multi-cloud

1. **Risk Mitigation**: Reduce dependency on a single cloud provider
2. **Geographic Distribution**: Deploy resources in different regions
3. **Cost Optimization**: Leverage competitive pricing between providers
4. **Vendor Lock-in Avoidance**: Maintain flexibility to switch providers
5. **Compliance Requirements**: Meet specific regulatory requirements

## Clean up

```bash
# Destroy the created resources
terraform destroy
```