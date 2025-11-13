output "huaweicloud_vpc_id" {
  description = "Huawei Cloud VPC ID"
  value       = module.huaweicloud_infrastructure.huaweicloud_vpc_id
}

output "huaweicloud_resources" {
  description = "All Huawei Cloud resources information"
  value       = module.huaweicloud_infrastructure.huaweicloud
}

output "enabled_providers" {
  description = "Enabled cloud providers"
  value       = module.huaweicloud_infrastructure.enabled_providers
}