variable "anycast_eip_address_name" {
  type        = string
  description = "The name of any cast service."
  default = null
}

variable "bandwidth" {
  type        = number
  description = "The bandwidth of eip anycast service."
  default = null
}

variable "description" {
  type        = string
  description = "The description of any cast service."
  default = null
}

variable "internet_charge_type" {
  type        = string
  description = "The Change type of Eip Anycast service."
  default = "PayByBandwidth"
}

variable "service_location" {
  type        = string
  description = "The location of any cast service."
  default = "international"
}

variable "bind_instance_id" {
  type        = string
  description = "The instance id which bind to eip Anycast service."
}

variable "bind_instance_region_id" {
  type        = string
  description = "The region which instance belong to."
}

variable "create" {
  description = "Whether to create resources in module."
  type        = bool
  default     = false
}