output "aws_vpc_id" {
  description = "AWS VPC ID"
  value       = module.aws_infrastructure.aws_vpc_id
}

output "aws_resources" {
  description = "All AWS resources information"
  value       = module.aws_infrastructure.aws
}

output "enabled_providers" {
  description = "Enabled cloud providers"
  value       = module.aws_infrastructure.enabled_providers
}