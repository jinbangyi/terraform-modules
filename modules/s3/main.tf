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
  statement {
    sid    = "S3BucketAndPrefixAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      data.aws_s3_bucket.existing_bucket.arn,                     # Bucket-level access for ListBucket
      "${data.aws_s3_bucket.existing_bucket.arn}/${var.prefix}/*" # Object-level access with prefix restriction
    ]
  }

  statement {
    sid    = "S3DenyAccessOutsidePrefix"
    effect = "Deny"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${data.aws_s3_bucket.existing_bucket.arn}/*"
    ]

    condition {
      test     = "StringNotLike"
      variable = "s3:prefix"
      values   = ["${var.prefix}/*"]
    }
  }

  statement {
    sid    = "S3DenyListOutsidePrefix"
    effect = "Deny"
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      data.aws_s3_bucket.existing_bucket.arn
    ]

    condition {
      test     = "StringNotLike"
      variable = "s3:prefix"
      values   = ["${var.prefix}/*", "${var.prefix}"]
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

# Optional: Create login profile if password is provided
resource "aws_iam_user_login_profile" "s3_user_profile" {
  count    = var.create_password ? 1 : 0
  user     = aws_iam_user.s3_user.name
  password = var.password
  pgp_key  = var.pgp_key != "" ? var.pgp_key : null
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