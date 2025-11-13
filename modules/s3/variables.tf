variable "bucket_name" {
  description = "Name of the existing S3 bucket to grant access to"
  type        = string
}

variable "prefix" {
  description = "S3 prefix (folder path) that the user will have access to"
  type        = string
  default     = ""
}

variable "user_name_prefix" {
  description = "Prefix for the IAM user name and related resources"
  type        = string
  default     = "s3-access"
}

variable "create_password" {
  description = "Whether to create a password for console access"
  type        = bool
  default     = false
}

variable "pgp_key" {
  description = "PGP key for encrypting the access key and password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "store_credentials_in_secrets_manager" {
  description = "Whether to store credentials in AWS Secrets Manager"
  type        = bool
  default     = false
}

variable "secret_recovery_window_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete a secret"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Advanced variables for fine-tuning permissions
variable "allowed_actions" {
  description = "List of allowed S3 actions for the IAM policy"
  type        = list(string)
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
    "s3:ListBucket",
    "s3:GetBucketLocation",
    "s3:ListBucketMultipartUploads",
    "s3:ListMultipartUploadParts",
    "s3:AbortMultipartUpload"
  ]
}

variable "read_only" {
  description = "Whether to grant read-only access only"
  type        = bool
  default     = false
}

variable "enable_multipart_upload" {
  description = "Whether to allow multipart upload operations"
  type        = bool
  default     = true
}

variable "user_path" {
  description = "Path for the IAM user"
  type        = string
  default     = "/system/s3-users/"
}