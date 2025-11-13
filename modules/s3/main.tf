# S3 Bucket IAM Access Module
# This module creates IAM user and API keys with restricted access to an existing S3 bucket and prefix

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Data source to get the existing S3 bucket
data "aws_s3_bucket" "existing_bucket" {
  bucket = var.bucket_name
}

# IAM policy document for S3 bucket access with prefix restriction
data "aws_iam_policy_document" "s3_bucket_access" {
  # Allow object-level operations only within the specified prefix
  statement {
    sid    = "S3ObjectAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      "${data.aws_s3_bucket.existing_bucket.arn}/${var.prefix}/*"
    ]
  }

  # Allow bucket-level operations with prefix restriction
  statement {
    sid    = "S3BucketLevelAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]

    resources = [
      data.aws_s3_bucket.existing_bucket.arn
    ]

    # Restrict ListBucket to only show objects within the prefix
    condition {
      test     = "StringLike"
      variable = "s3:prefix"
      values   = [
        "${var.prefix}/*",
        "${var.prefix}"
      ]
    }
  }

  # Allow ListBucket without prefix parameter (required for some operations)
  statement {
    sid    = "S3ListBucketRoot"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      data.aws_s3_bucket.existing_bucket.arn
    ]

    condition {
      test     = "StringLike"
      variable = "s3:delimiter"
      values   = ["/"]
    }
  }
}

# IAM policy for S3 access
resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.user_name_prefix}-s3-access-policy"
  description = "Policy for accessing S3 bucket ${var.bucket_name} with prefix ${var.prefix}"
  policy      = data.aws_iam_policy_document.s3_bucket_access.json

  tags = merge(
    var.tags,
    {
      Name        = "${var.user_name_prefix}-s3-access-policy"
      BucketName  = var.bucket_name
      Prefix      = var.prefix
    }
  )
}

# IAM user for S3 access
resource "aws_iam_user" "s3_user" {
  name = "${var.user_name_prefix}-s3-user"
  path = "/system/s3-users/"

  tags = merge(
    var.tags,
    {
      Name        = "${var.user_name_prefix}-s3-user"
      BucketName  = var.bucket_name
      Prefix      = var.prefix
    }
  )
}

# Attach policy to user
resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Create access key for the IAM user
resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name

  pgp_key = var.pgp_key != "" ? var.pgp_key : null
}

# Optional: Create login profile if password creation is enabled
resource "aws_iam_user_login_profile" "s3_user_profile" {
  count   = var.create_password ? 1 : 0
  user    = aws_iam_user.s3_user.name
  pgp_key = var.pgp_key != "" ? var.pgp_key : null

  # Password length must be between 4 and 128 characters
  password_length        = 16
  password_reset_required = true

  lifecycle {
    ignore_changes = [password_length, password_reset_required]
  }
}

# Store the bucket prefix as a secret for verification
resource "aws_secretsmanager_secret" "s3_access_info" {
  count                   = var.store_credentials_in_secrets_manager ? 1 : 0
  name                    = "${var.user_name_prefix}-s3-access"
  description             = "S3 access information for bucket ${var.bucket_name} and prefix ${var.prefix}"
  recovery_window_in_days = var.secret_recovery_window_days

  tags = merge(
    var.tags,
    {
      Name        = "${var.user_name_prefix}-s3-access"
      BucketName  = var.bucket_name
      Prefix      = var.prefix
    }
  )
}

# Store credentials in Secrets Manager
resource "aws_secretsmanager_secret_version" "s3_access_info" {
  count         = var.store_credentials_in_secrets_manager ? 1 : 0
  secret_id     = aws_secretsmanager_secret.s3_access_info[0].id
  secret_string = jsonencode({
    bucket_name       = var.bucket_name
    prefix           = var.prefix
    access_key_id    = aws_iam_access_key.s3_user_key.id
    secret_access_key = var.pgp_key != "" ? "Encrypted with PGP" : aws_iam_access_key.s3_user_key.secret
    user_arn         = aws_iam_user.s3_user.arn
    policy_arn       = aws_iam_policy.s3_access_policy.arn
  })
}