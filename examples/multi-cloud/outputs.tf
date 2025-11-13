output "aws_resources" {
  description = "AWS resources information"
  value       = module.multi_cloud_infrastructure.aws
}

output "huaweicloud_resources" {
  description = "Huawei Cloud resources information"
  value       = module.multi_cloud_infrastructure.huaweicloud
}

output "enabled_providers" {
  description = "Enabled cloud providers"
  value       = module.multi_cloud_infrastructure.enabled_providers
}

output "aws_vpc_id" {
  description = "AWS VPC ID"
  value       = module.multi_cloud_infrastructure.aws_vpc_id
}

output "huaweicloud_vpc_id" {
  description = "Huawei Cloud VPC ID"
  value       = module.multi_cloud_infrastructure.huaweicloud_vpc_id
}