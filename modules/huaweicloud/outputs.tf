output "vpc_id" {
  description = "ID of the VPC"
  value       = huaweicloud_vpc_v1.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = huaweicloud_vpc_v1.main.cidr
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = huaweicloud_vpc_subnet_v1.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = huaweicloud_vpc_subnet_v1.private[*].id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = huaweicloud_networking_secgroup_v2.main.id
}

output "instance_id" {
  description = "ID of the ECS instance"
  value       = try(huaweicloud_compute_instance_v2.main[0].id, null)
}

output "instance_public_ip" {
  description = "Public IP of the ECS instance"
  value       = try(huaweicloud_compute_instance_v2.main[0].access_ip_v4, null)
}

output "availability_zones" {
  description = "List of availability zones"
  value       = data.huaweicloud_availability_zones.available.names
}