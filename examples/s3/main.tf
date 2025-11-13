# S3 Bucket Access Example
# This example demonstrates how to use the S3 module to create IAM users with restricted access to existing buckets

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Example 1: Create user with access to entire bucket
module "s3_full_bucket_access" {
  source = "../../modules/s3"

  bucket_name       = "my-existing-bucket"
  prefix           = ""  # Empty prefix means access to entire bucket
  user_name_prefix = "full-bucket"

  tags = {
    "Project"     = "s3-access-example"
    "Environment" = "production"
    "AccessLevel" = "full-bucket"
  }
}

# Example 2: Create user with access to specific prefix (folder)
module "s3_prefix_access" {
  source = "../../modules/s3"

  bucket_name       = "my-existing-bucket"
  prefix           = "user-uploads/documents"
  user_name_prefix = "doc-uploader"

  tags = {
    "Project"     = "s3-access-example"
    "Environment" = "production"
    "AccessLevel" = "prefix-only"
  }
}

# Example 3: Create read-only user for specific prefix
module "s3_readonly_access" {
  source = "../../modules/s3"

  bucket_name       = "my-existing-bucket"
  prefix           = "public-files"
  user_name_prefix = "readonly-user"
  read_only        = true

  tags = {
    "Project"     = "s3-access-example"
    "Environment" = "production"
    "AccessLevel" = "read-only"
  }
}

# Example 4: Create user with encrypted credentials stored in Secrets Manager
module "s3_secure_access" {
  source = "../../modules/s3"

  bucket_name                      = "my-secure-bucket"
  prefix                          = "secure-data"
  user_name_prefix                = "secure-user"
  create_password                 = true
  password                        = "SecurePassword123!" # In production, use a generated password or secret
  store_credentials_in_secrets_manager = true

  tags = {
    "Project"     = "s3-access-example"
    "Environment" = "production"
    "AccessLevel" = "secure"
  }
}

# Example 5: Create user with PGP-encrypted credentials
module "s3_pgp_access" {
  source = "../../modules/s3"

  bucket_name       = "my-pgp-bucket"
  prefix           = "encrypted-files"
  user_name_prefix = "pgp-user"
  pgp_key           = "keybase:yourusername" # Replace with your actual PGP key

  tags = {
    "Project"     = "s3-access-example"
    "Environment" = "production"
    "AccessLevel" = "pgp-encrypted"
  }
}