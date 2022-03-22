provider "alicloud" {
  region = var.slb_region
  alias = "backend"
}

data "alicloud_zones" "default" {
  provider = alicloud.backend
  available_resource_creation = "VSwitch"
}

data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_vpc" "default" {
  provider = alicloud.backend
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "default" {
  provider = alicloud.backend
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = var.vswitch_cidr_block
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.vswitch_name
}

resource "alicloud_slb" "default" {
  provider = alicloud.backend
  load_balancer_name = var.slb_instance_name
  load_balancer_spec  = var.load_balancer_spec
  vswitch_id          = alicloud_vswitch.default.id
}

resource "alicloud_eipanycast_anycast_eip_address" "example" {
  service_location = var.eip-anycast-service-location
}

resource "alicloud_eipanycast_anycast_eip_address_attachment" "example" {
  anycast_id              = alicloud_eipanycast_anycast_eip_address.example.id
  bind_instance_id        = alicloud_slb.default.id
  bind_instance_region_id = data.alicloud_regions.default.regions.0.id
  bind_instance_type      = "SlbInstance"
}