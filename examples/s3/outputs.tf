# Example outputs for different access levels

output "full_bucket_access" {
  description = "Full bucket access user credentials"
  value       = module.s3_full_bucket_access
  sensitive   = true
}

output "prefix_access" {
  description = "Prefix-only access user credentials"
  value       = module.s3_prefix_access
  sensitive   = true
}

output "readonly_access" {
  description = "Read-only access user credentials"
  value       = module.s3_readonly_access
  sensitive   = true
}

output "secure_access" {
  description = "Secure access user credentials"
  value       = module.s3_secure_access
  sensitive   = true
}

output "pgp_access" {
  description = "PGP-encrypted access user credentials"
  value       = module.s3_pgp_access
  sensitive   = true
}

# Non-sensitive outputs for demonstration
output "example_s3_urls" {
  description = "S3 URLs for different access scenarios"
  value = {
    full_bucket = module.s3_full_bucket_access.s3_url
    prefix      = module.s3_prefix_access.s3_url
    readonly    = module.s3_readonly_access.s3_url
    secure      = module.s3_secure_access.s3_url
    pgp         = module.s3_pgp_access.s3_url
  }
}

output "example_user_arns" {
  description = "IAM user ARNs for all examples"
  value = {
    full_bucket = module.s3_full_bucket_access.user_arn
    prefix      = module.s3_prefix_access.user_arn
    readonly    = module.s3_readonly_access.user_arn
    secure      = module.s3_secure_access.user_arn
    pgp         = module.s3_pgp_access.user_arn
  }
}