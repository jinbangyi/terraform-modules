# Multi-Cloud Terraform Module

A comprehensive Terraform module template supporting multi-cloud resource management for AWS and Huawei Cloud, following best practices for creating reusable and maintainable infrastructure as code.

## Features

- ✅ Multi-cloud support (AWS & Huawei Cloud)
- ✅ Conditional resource creation
- ✅ Follows Terraform best practices
- ✅ Semantic versioning support
- ✅ Comprehensive documentation
- ✅ Input/output variables
- ✅ Flexible tagging strategy
- ✅ Multiple deployment examples
- ✅ Automated testing ready

## Supported Cloud Providers

- **AWS**: VPC, Subnets, Security Groups, EC2 instances, S3 Bucket Access Management
- **Huawei Cloud**: VPC, Subnets, Security Groups, ECS instances

## Available Modules

### Multi-Cloud Infrastructure Modules
- **AWS Module** (`modules/aws/`): VPC, Subnets, Security Groups, EC2 instances
- **Huawei Cloud Module** (`modules/huaweicloud/`): VPC, Subnets, Security Groups, ECS instances

### Specialized Modules
- **S3 Bucket Access Module** (`modules/s3/`): Create IAM users with restricted S3 bucket and prefix access

## Usage

### AWS-only Deployment

```hcl
module "aws_infrastructure" {
  source = "./path/to/this/module"

  name        = "my-app"
  environment = "production"

  # Enable AWS resources only
  enable_aws        = true
  enable_huaweicloud = false

  # AWS Configuration
  aws_region        = "us-west-2"
  aws_vpc_cidr      = "10.0.0.0/16"
  aws_instance_type = "t3.micro"
  aws_create_instance = true

  tags = {
    "Project"     = "my-project"
    "Owner"       = "team@example.com"
    "Environment" = "production"
  }
}
```

### Huawei Cloud-only Deployment

```hcl
module "huaweicloud_infrastructure" {
  source = "./path/to/this/module"

  name        = "my-app"
  environment = "production"

  # Enable Huawei Cloud resources only
  enable_aws        = false
  enable_huaweicloud = true

  # Huawei Cloud Configuration
  huaweicloud_region = "cn-north-4"
  huaweicloud_vpc_cidr = "192.168.0.0/16"
  huaweicloud_flavor = "s6.small.1"
  huaweicloud_create_instance = true

  tags = {
    "Project"     = "my-project"
    "Owner"       = "team@example.com"
    "Environment" = "production"
  }
}
```

### Multi-cloud Deployment

```hcl
module "multi_cloud_infrastructure" {
  source = "./path/to/this/module"

  name        = "my-app"
  environment = "production"

  # Enable both cloud providers
  enable_aws        = true
  enable_huaweicloud = true

  # AWS Configuration
  aws_region        = "us-west-2"
  aws_vpc_cidr      = "10.0.0.0/16"
  aws_instance_type = "t3.micro"
  aws_create_instance = true

  # Huawei Cloud Configuration
  huaweicloud_region = "cn-north-4"
  huaweicloud_vpc_cidr = "192.168.0.0/16"
  huaweicloud_flavor = "s6.small.1"
  huaweicloud_create_instance = true

  tags = {
    "Project"     = "my-project"
    "Owner"       = "team@example.com"
    "Environment" = "production"
    "ManagedBy"   = "Terraform"
  }
}
```

### S3 Bucket Access Module

Create IAM users with restricted access to existing S3 buckets and specific prefixes:

```hcl
module "s3_bucket_access" {
  source = "./modules/s3"

  # Required: Existing bucket name and prefix
  bucket_name       = "my-existing-bucket"
  prefix           = "user-uploads/documents"
  user_name_prefix = "doc-uploader"

  # Optional: Security options
  read_only                         = false
  store_credentials_in_secrets_manager = true
  create_password                   = true

  tags = {
    "Project"     = "my-project"
    "Environment" = "production"
    "AccessLevel" = "prefix-only"
  }
}
```

## Module Features

### S3 Bucket Access Module Features:
- ✅ **Existing Bucket Integration**: Works with existing S3 buckets
- ✅ **Prefix-Based Access**: Restrict access to specific S3 prefixes (folders)
- ✅ **IAM User Creation**: Automatically creates IAM users with minimal permissions
- ✅ **Access Key Generation**: Generates AWS access keys for programmatic access
- ✅ **Security Options**: PGP encryption, Secrets Manager integration, console access
- ✅ **Read-Only Mode**: Option for read-only access
- ✅ **Explicit Deny Policies**: Prevents access to other parts of the bucket

## Inputs

### Core Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name prefix for resources | `string` | `"terraform-module"` | no |
| environment | Environment name (e.g., dev, staging, prod) | `string` | `"dev"` | no |
| tags | A map of tags to assign to resources | `map(string)` | `{<br>  "Terraform": "true"<br>  "ManagedBy": "Terraform"<br>  "Environment": "dev"<br>}` | no |

### Cloud Provider Selection

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| enable_aws | Enable AWS resources | `bool` | `false` | no |
| enable_huaweicloud | Enable Huawei Cloud resources | `bool` | `false` | no |

### AWS Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| aws_region | AWS region | `string` | `"us-west-2"` | no |
| aws_vpc_cidr | CIDR block for AWS VPC | `string` | `"10.0.0.0/16"` | no |
| aws_public_subnet_cidrs | List of CIDR blocks for AWS public subnets | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| aws_private_subnet_cidrs | List of CIDR blocks for AWS private subnets | `list(string)` | `["10.0.10.0/24", "10.0.20.0/24"]` | no |
| aws_instance_type | AWS EC2 instance type | `string` | `"t3.micro"` | no |
| aws_create_instance | Whether to create AWS EC2 instance | `bool` | `false` | no |

### Huawei Cloud Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| huaweicloud_region | Huawei Cloud region | `string` | `"cn-north-4"` | no |
| huaweicloud_vpc_cidr | CIDR block for Huawei Cloud VPC | `string` | `"192.168.0.0/16"` | no |
| huaweicloud_public_subnet_cidrs | List of CIDR blocks for Huawei Cloud public subnets | `list(string)` | `["192.168.1.0/24", "192.168.2.0/24"]` | no |
| huaweicloud_private_subnet_cidrs | List of CIDR blocks for Huawei Cloud private subnets | `list(string)` | `["192.168.10.0/24", "192.168.20.0/24"]` | no |
| huaweicloud_flavor | Huawei Cloud ECS instance flavor | `string` | `"s6.small.1"` | no |
| huaweicloud_create_instance | Whether to create Huawei Cloud ECS instance | `bool` | `false` | no |

### S3 Bucket Access Module

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the existing S3 bucket to grant access to | `string` | n/a | yes |
| prefix | S3 prefix (folder path) that the user will have access to | `string` | `""` | no |
| user_name_prefix | Prefix for the IAM user name and related resources | `string` | `"s3-access"` | no |
| read_only | Whether to grant read-only access only | `bool` | `false` | no |
| create_password | Whether to create a password for console access | `bool` | `false` | no |
| store_credentials_in_secrets_manager | Whether to store credentials in AWS Secrets Manager | `bool` | `false` | no |
| pgp_key | PGP key for encrypting the access key and password | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| module_name | Name of the module |
| environment | Environment name |
| tags | Tags applied to resources |
| example_file_path | Path to the example file |
| aws | AWS resources information (conditional) |
| huaweicloud | Huawei Cloud resources information (conditional) |
| aws_vpc_id | AWS VPC ID (conditional) |
| huaweicloud_vpc_id | Huawei Cloud VPC ID (conditional) |
| enabled_providers | List of enabled cloud providers |

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.0 |
| huaweicloud | ~> 1.50 |
| local | ~> 2.0 |

## Development

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) (for AWS deployments)
- [Huawei Cloud CLI](https://support.huaweicloud.com/en-us/usermanual-cli/en-us_topic_0173628347.html) (for Huawei Cloud deployments)
- [Terraform Docs](https://github.com/terraform-docs/terraform-docs) (for documentation generation)

### Project Structure

```
.
├── main.tf                      # Main configuration with multi-cloud support
├── variables.tf                 # Input variables for all cloud providers
├── outputs.tf                   # Output values for all cloud providers
├── README.md                    # Module documentation
├── modules/                     # Cloud-specific modules
│   ├── aws/                     # AWS-specific resources
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── huaweicloud/             # Huawei Cloud-specific resources
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── examples/                    # Usage examples
│   ├── basic/                   # Basic usage example
│   ├── aws/                     # AWS-only deployment example
│   ├── huaweicloud/             # Huawei Cloud-only deployment example
│   ├── multi-cloud/             # Multi-cloud deployment example
│   └── s3/                      # S3 bucket access examples
└── docs/                        # Additional documentation
```

### Best Practices Implemented

1. **Multi-cloud Architecture**: Supports multiple cloud providers with consistent interface
2. **Conditional Resource Creation**: Enables/disables resources based on configuration
3. **Semantic Versioning**: Follows semantic versioning for releases
4. **Consistent Naming**: Uses consistent naming conventions across providers
5. **Comprehensive Documentation**: Auto-generated and manually maintained documentation
6. **Flexible Tagging Strategy**: Implements a flexible tagging strategy for all resources
7. **Input Validation**: Includes proper variable descriptions and defaults
8. **Output Management**: Provides useful outputs for consumption
9. **Modular Design**: Cloud-specific resources organized in separate modules

### Examples

The module includes multiple deployment examples:

- **Basic Example** (`examples/basic/`): Demonstrates basic module usage
- **AWS-only Example** (`examples/aws/`): Deploy resources only on AWS
- **Huawei Cloud-only Example** (`examples/huaweicloud/`): Deploy resources only on Huawei Cloud
- **Multi-cloud Example** (`examples/multi-cloud/`): Deploy resources on both clouds simultaneously
- **S3 Bucket Access Examples** (`examples/s3/`): Various S3 access scenarios including prefix-based access, read-only access, and secure credential management

### Testing

```bash
# Test AWS-only deployment
cd examples/aws
terraform init
terraform validate

# Test Huawei Cloud-only deployment
cd ../huaweicloud
terraform init
terraform validate

# Test multi-cloud deployment
cd ../multi-cloud
terraform init
terraform validate

# Test S3 bucket access module
cd ../s3
terraform init
terraform validate

# Format code
terraform fmt -check

# Generate documentation
terraform-docs markdown . > README.md
```

### Multi-cloud Benefits

1. **Risk Mitigation**: Reduce dependency on a single cloud provider
2. **Geographic Distribution**: Deploy resources in different regions
3. **Cost Optimization**: Leverage competitive pricing between providers
4. **Vendor Lock-in Avoidance**: Maintain flexibility to switch providers
5. **Compliance Requirements**: Meet specific regulatory requirements
6. **High Availability**: Distribute infrastructure across multiple clouds

### Authentication Setup

#### AWS Authentication
```bash
# Configure AWS CLI
aws configure
# or set environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-west-2"
```

#### Huawei Cloud Authentication
```bash
# Configure Huawei Cloud CLI
aksk configure set --ak your-access-key --sk your-secret-key --project-name your-project-name
# or set environment variables
export HUAWEICLOUD_ACCESS_KEY="your-access-key"
export HUAWEICLOUD_SECRET_KEY="your-secret-key"
export HUAWEICLOUD_PROJECT_NAME="your-project-name"
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Authors

- **Your Name** - *Initial work* - [YourUsername](https://github.com/YourUsername)

## Acknowledgments

- [HashiCorp Terraform](https://www.terraform.io/)
- [Terraform Module Registry](https://registry.terraform.io/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/repository.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Huawei Cloud Provider Documentation](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs)

## Changelog

### [0.1.0] - 2024-01-01

#### Added
- Multi-cloud Terraform module template
- AWS and Huawei Cloud provider support
- Conditional resource creation
- Comprehensive documentation and examples
- Cloud-specific modules for better organization
- Multiple deployment scenarios (single-cloud and multi-cloud)