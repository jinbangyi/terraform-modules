# Huawei Cloud VPC
resource "huaweicloud_vpc_v1" "main" {
  name = "${var.name_prefix}-vpc-${var.environment}"
  cidr = var.vpc_cidr

  tags = var.tags
}

# Huawei Cloud Subnets
resource "huaweicloud_vpc_subnet_v1" "public" {
  count = length(var.public_cidrs)

  name       = "${var.name_prefix}-public-subnet-${count.index + 1}-${var.environment}"
  vpc_id     = huaweicloud_vpc_v1.main.id
  cidr       = var.public_cidrs[count.index]
  gateway_ip = cidrhost(var.public_cidrs[count.index], 1)

  tags = merge(
    var.tags,
    {
      Type = "Public"
    }
  )
}

resource "huaweicloud_vpc_subnet_v1" "private" {
  count = length(var.private_cidrs)

  name       = "${var.name_prefix}-private-subnet-${count.index + 1}-${var.environment}"
  vpc_id     = huaweicloud_vpc_v1.main.id
  cidr       = var.private_cidrs[count.index]
  gateway_ip = cidrhost(var.private_cidrs[count.index], 1)

  tags = merge(
    var.tags,
    {
      Type = "Private"
    }
  )
}

# Huawei Cloud Security Group
resource "huaweicloud_networking_secgroup_v2" "main" {
  name        = "${var.name_prefix}-sg-${var.environment}"
  description = "Security group for ${var.name_prefix} in ${var.environment}"

  tags = var.tags
}

# Security Group Rules
resource "huaweicloud_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup_v2.main.id
}

resource "huaweicloud_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup_v2.main.id
}

resource "huaweicloud_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup_v2.main.id
}

resource "huaweicloud_networking_secgroup_rule_v2" "egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "any"
  port_range_min    = null
  port_range_max    = null
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup_v2.main.id
}

# Huawei Cloud ECS Instance (example)
resource "huaweicloud_compute_instance_v2" "main" {
  count = var.create_instance ? 1 : 0

  name              = "${var.name_prefix}-instance-${var.environment}"
  image_id          = data.huaweicloud_images_image_v2.centos.id
  flavor_id         = data.huaweicloud_compute_flavor_v2.main.id
  security_groups   = [huaweicloud_networking_secgroup_v2.main.name]
  availability_zone = data.huaweicloud_availability_zones.available.names[0]

  network {
    uuid = huaweicloud_vpc_subnet_v1.public[0].id
  }

  tags = var.tags
}

# Data sources
data "huaweicloud_availability_zones" "available" {}

data "huaweicloud_compute_flavor_v2" "main" {
  name = var.flavor
}

data "huaweicloud_images_image_v2" "centos" {
  name        = "CentOS 7.6 64bit"
  most_recent = true
  visibility  = "public"
}