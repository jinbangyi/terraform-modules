output "module_name" {
  description = "Name of the module"
  value       = var.name
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "tags" {
  description = "Tags applied to resources"
  value       = var.tags
}

# Example output for the local_file resource
output "example_file_path" {
  description = "Path to the example file"
  value       = local_file.example.filename
}

# AWS Outputs (conditional)
output "aws" {
  description = "AWS resources information"
  value       = var.enable_aws ? {
    vpc_id           = try(module.aws_resources[0].vpc_id, null)
    vpc_cidr_block   = try(module.aws_resources[0].vpc_cidr_block, null)
    public_subnet_ids = try(module.aws_resources[0].public_subnet_ids, null)
    private_subnet_ids = try(module.aws_resources[0].private_subnet_ids, null)
    security_group_id = try(module.aws_resources[0].security_group_id, null)
    instance_id       = try(module.aws_resources[0].instance_id, null)
    instance_public_ip = try(module.aws_resources[0].instance_public_ip, null)
    availability_zones = try(module.aws_resources[0].availability_zones, null)
  } : null
}

# Huawei Cloud Outputs (conditional)
output "huaweicloud" {
  description = "Huawei Cloud resources information"
  value       = var.enable_huaweicloud ? {
    vpc_id             = try(module.huaweicloud_resources[0].vpc_id, null)
    vpc_cidr           = try(module.huaweicloud_resources[0].vpc_cidr, null)
    public_subnet_ids  = try(module.huaweicloud_resources[0].public_subnet_ids, null)
    private_subnet_ids = try(module.huaweicloud_resources[0].private_subnet_ids, null)
    security_group_id  = try(module.huaweicloud_resources[0].security_group_id, null)
    instance_id        = try(module.huaweicloud_resources[0].instance_id, null)
    instance_public_ip = try(module.huaweicloud_resources[0].instance_public_ip, null)
    availability_zones = try(module.huaweicloud_resources[0].availability_zones, null)
  } : null
}

# Simplified outputs for specific resources
output "aws_vpc_id" {
  description = "AWS VPC ID"
  value       = var.enable_aws ? try(module.aws_resources[0].vpc_id, null) : null
}

output "huaweicloud_vpc_id" {
  description = "Huawei Cloud VPC ID"
  value       = var.enable_huaweicloud ? try(module.huaweicloud_resources[0].vpc_id, null) : null
}

output "enabled_providers" {
  description = "List of enabled cloud providers"
  value = compact([
    var.enable_aws ? "aws" : "",
    var.enable_huaweicloud ? "huaweicloud" : ""
  ])
}