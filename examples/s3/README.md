# S3 Bucket Access Examples

This directory contains examples demonstrating how to use the S3 module to create IAM users with restricted access to existing S3 buckets.

## Prerequisites

- An existing S3 bucket
- AWS CLI configured with appropriate credentials
- Terraform >= 1.0

## Examples

### 1. Full Bucket Access
Creates an IAM user with access to the entire S3 bucket.

```hcl
module "s3_full_bucket_access" {
  source = "../../modules/s3"

  bucket_name       = "my-existing-bucket"
  prefix           = ""  # Empty prefix means access to entire bucket
  user_name_prefix = "full-bucket"
  create_password  = false  # No console access, only API keys
}
```

### 2. Prefix-Only Access
Creates an IAM user with access only to a specific S3 prefix (folder).

```hcl
module "s3_prefix_access" {
  source = "../../modules/s3"

  bucket_name       = "my-existing-bucket"
  prefix           = "user-uploads/documents"
  user_name_prefix = "doc-uploader"
  create_password  = false  # No console access, only API keys
}
```

### 3. Read-Only Access
Creates an IAM user with read-only access to a specific prefix.

```hcl
module "s3_readonly_access" {
  source = "../../modules/s3"

  bucket_name       = "my-existing-bucket"
  prefix           = "public-files"
  user_name_prefix = "readonly-user"
  read_only        = true
}
```

### 4. Secure Access with Secrets Manager
Creates an IAM user with credentials stored in AWS Secrets Manager.

```hcl
module "s3_secure_access" {
  source = "../../modules/s3"

  bucket_name                      = "my-secure-bucket"
  prefix                          = "secure-data"
  user_name_prefix                = "secure-user"
  create_password                 = true
  store_credentials_in_secrets_manager = true
  # Password will be auto-generated since none is provided
}
```

### 5. PGP-Encrypted Credentials
Creates an IAM user with PGP-encrypted credentials.

```hcl
module "s3_pgp_access" {
  source = "../../modules/s3"

  bucket_name       = "my-pgp-bucket"
  prefix           = "encrypted-files"
  user_name_prefix = "pgp-user"
  pgp_key           = "keybase:yourusername"
  create_password  = false  # No console access, only API keys
}
```

## Usage

1. **Update the bucket name** in `main.tf` to match your existing S3 bucket
2. **Customize the prefixes** according to your folder structure
3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Plan the deployment:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   ```

## Accessing S3 with Generated Credentials

After deployment, you can use the generated credentials to access S3:

### Using AWS CLI

```bash
# Configure AWS CLI with the generated credentials
aws configure set aws_access_key_id <ACCESS_KEY_ID>
aws configure set aws_secret_access_key <SECRET_ACCESS_KEY>
aws configure set default.region us-east-1

# List files in the allowed prefix
aws s3 ls s3://my-bucket/user-uploads/documents/

# Upload a file
aws s3 cp local-file.txt s3://my-bucket/user-uploads/documents/

# Download a file
aws s3 cp s3://my-bucket/user-uploads/documents/remote-file.txt ./
```

### Using Other Tools

The generated credentials can be used with:
- AWS SDKs (Python, Java, Node.js, etc.)
- S3-compatible tools (Cyberduck, FileZilla Pro, etc.)
- Custom applications using AWS SDKs

## Security Considerations

1. **Least Privilege**: Users only have access to the specified bucket and prefix
2. **Prefix Restrictions**: Deny policies prevent access to other parts of the bucket
3. **Credential Management**:
   - Store credentials securely
   - Rotate access keys regularly
   - Use PGP encryption for sensitive scenarios
   - Consider using Secrets Manager for production workloads

## Clean up

```bash
# Destroy the created resources
terraform destroy
```

## Password Management

The module provides flexible password options:

### 1. No Console Access (Default)
```hcl
create_password = false  # Only API access keys, no console access
```

### 2. Auto-generated Password
```hcl
create_password = true
# password = ""  # Empty password will auto-generate a secure one
```

### 3. Custom Password
```hcl
create_password = true
password = "YourSecurePassword123!"  # Must meet complexity requirements
```

### 4. PGP-Encrypted Password
```hcl
create_password = true
pgp_key = "keybase:yourusername"  # Encrypts both access key and password
```

## Important Notes

- The bucket must already exist before running this module
- The IAM user cannot access files outside the specified prefix
- Prefix restrictions are enforced through explicit deny policies
- Console access requires `create_password = true`
- If `create_password = true` and no password is provided, a secure random password will be generated
- Custom passwords must be at least 8 characters with uppercase, lowercase, and numbers
- PGP encryption requires a valid PGP key identifier
- Generated passwords can be retrieved from the `password` output