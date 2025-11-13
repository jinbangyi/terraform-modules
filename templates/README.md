# Configuration Templates

This directory contains configuration templates to help you get started with the multi-cloud Terraform module.

## Templates

### 1. `terraform.tfvars.example`
Example configuration file for all module variables. Copy this file to `terraform.tfvars` and modify the values according to your requirements.

```bash
# Copy the example file
cp templates/terraform.tfvars.example terraform.tfvars

# Edit the file with your preferred editor
vim terraform.tfvars
```

### 2. `provider.tf.aws.example`
AWS provider configuration example. This shows different ways to configure AWS credentials:

- **Static credentials** (not recommended for production)
- **Environment variables** (recommended)
- **IAM roles** (recommended for EC2 instances)
- **AWS profiles** (for local development)

### 3. `provider.tf.huaweicloud.example`
Huawei Cloud provider configuration example. This shows different ways to configure Huawei Cloud credentials:

- **Static credentials** (not recommended for production)
- **Environment variables** (recommended)
- **Configuration file** (for local development)
- **Agency** (for temporary credentials)

## Quick Start

1. **Choose your deployment scenario:**
   - AWS-only: Use `templates/provider.tf.aws.example`
   - Huawei Cloud-only: Use `templates/provider.tf.huaweicloud.example`
   - Multi-cloud: Use both provider templates

2. **Set up credentials:**
   ```bash
   # For AWS
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   export AWS_DEFAULT_REGION="us-west-2"

   # For Huawei Cloud
   export HUAWEICLOUD_ACCESS_KEY="your-access-key"
   export HUAWEICLOUD_SECRET_KEY="your-secret-key"
   export HUAWEICLOUD_PROJECT_NAME="your-project-name"
   export HUAWEICLOUD_REGION_NAME="cn-north-4"
   ```

3. **Configure variables:**
   ```bash
   cp templates/terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your configuration
   ```

4. **Deploy:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Security Best Practices

1. **Never commit credentials to version control**
2. **Use environment variables or secure credential stores**
3. **Rotate credentials regularly**
4. **Use least-privilege IAM policies**
5. **Enable MFA for cloud accounts**
6. **Monitor cloud resource usage and costs**

## Environment-Specific Configurations

### Development
```hcl
# terraform.tfvars
environment = "dev"
enable_aws = true
enable_huaweicloud = false
aws_create_instance = false
```

### Staging
```hcl
# terraform.tfvars
environment = "staging"
enable_aws = true
enable_huaweicloud = true
aws_create_instance = true
huaweicloud_create_instance = false
```

### Production
```hcl
# terraform.tfvars
environment = "production"
enable_aws = true
enable_huaweicloud = true
aws_create_instance = true
huaweicloud_create_instance = true
```