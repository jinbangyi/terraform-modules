# Example variables for S3 access module

variable "existing_bucket_name" {
  description = "Name of an existing S3 bucket for the examples"
  type        = string
  default     = "my-existing-bucket"

  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.existing_bucket_name))
    error_message = "Bucket name must be lowercase, numbers, dots, and hyphens only."
  }
}

variable "admin_email" {
  description = "Admin email for notifications (optional)"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "s3-access-demo"
}