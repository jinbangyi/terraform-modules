output "bucket_name" {
  description = "The S3 bucket name"
  value       = var.bucket_name
}

output "prefix" {
  description = "The S3 prefix that the user has access to"
  value       = var.prefix
}

output "user_name" {
  description = "The IAM user name"
  value       = aws_iam_user.s3_user.name
}

output "user_arn" {
  description = "The IAM user ARN"
  value       = aws_iam_user.s3_user.arn
}

output "access_key_id" {
  description = "The access key ID"
  value       = aws_iam_access_key.s3_user_key.id
  sensitive   = false
}

output "secret_access_key" {
  description = "The secret access key"
  value       = aws_iam_access_key.s3_user_key.secret
  sensitive   = true
}

output "access_key_encrypted_secret" {
  description = "The encrypted secret access key (if PGP key is provided)"
  value       = aws_iam_access_key.s3_user_key.encrypted_secret
  sensitive   = true
}

output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = aws_iam_policy.s3_access_policy.arn
}

output "policy_name" {
  description = "The name of the IAM policy"
  value       = aws_iam_policy.s3_access_policy.name
}

output "secrets_manager_secret_arn" {
  description = "The ARN of the Secrets Manager secret (if created)"
  value       = var.store_credentials_in_secrets_manager ? aws_secretsmanager_secret.s3_access_info[0].arn : null
}

output "secrets_manager_secret_name" {
  description = "The name of the Secrets Manager secret (if created)"
  value       = var.store_credentials_in_secrets_manager ? aws_secretsmanager_secret.s3_access_info[0].name : null
}

output "credentials_for_aws_cli" {
  description = "Formatted credentials for AWS CLI configuration"
  value       = {
    aws_access_key_id     = aws_iam_access_key.s3_user_key.id
    aws_secret_access_key = aws_iam_access_key.s3_user_key.secret
    region                = "us-east-1" # Default region, user should update this
  }
  sensitive = true
}

output "password_encrypted" {
  description = "The encrypted console password (if PGP key is provided and password was created)"
  value       = var.create_password && var.pgp_key != "" ? try(aws_iam_user_login_profile.s3_user_profile[0].encrypted_password, null) : null
  sensitive   = true
}

output "s3_url" {
  description = "The S3 URL for the bucket"
  value       = "s3://${var.bucket_name}/${var.prefix != "" ? "${var.prefix}/" : ""}"
}

output "allowed_s3_path" {
  description = "The S3 path pattern that the user can access"
  value       = "${var.bucket_name}/${var.prefix != "" ? "${var.prefix}/*" : "*"}"
}