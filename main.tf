resource "alicloud_eipanycast_anycast_eip_address" "eip_address" {
  count                    = var.create ? 1 : 0
  service_location         = var.service_location
  anycast_eip_address_name = var.anycast_eip_address_name
  bandwidth                = var.bandwidth
  description              = var.description
  internet_charge_type     = var.internet_charge_type
}

resource "alicloud_eipanycast_anycast_eip_address_attachment" "eip_address_attachment" {
  count                   = var.create ? 1 : 0
  anycast_id              = concat(alicloud_eipanycast_anycast_eip_address.eip_address.*.id, [""])[0]
  bind_instance_id        = var.bind_instance_id
  bind_instance_region_id = var.bind_instance_region_id
  bind_instance_type      = "SlbInstance"
}