variable "vswitch_name" {
  type = string
  default = "tf_vswitch_name"
  description = "The name of vswitch."
}

variable "vswitch_cidr_block" {
  type = string
  default = "172.16.0.0/21"
  description = "The CIDR block for the switch."
}

variable "slb_instance_name" {
  type = string
  default = "tf_slb_name"
  description = "The name of slb."
}

variable "load_balancer_spec" {
  type = string
  default = "slb.s2.small"
  description = "The specification of slb."
}

variable "vpc_cidr_block" {
  type = string
  default = "172.16.0.0/12"
  description = "The CIDR block for the VPC"
}

variable "vpc_name" {
  type = string
  default = "tf_default_vpcname"
  description = "The name of vpc."
}