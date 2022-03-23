output "this_eip_anycast_service_id" {
  description = "The EIP Anycast service ID."
  value       = concat(alicloud_eipanycast_anycast_eip_address.eip_address.*.id, [""])[0]
}