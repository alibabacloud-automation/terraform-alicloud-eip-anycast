terraform-alicloud-eip-anycast
=====================================================================

本 Module 用于在阿里云创建 [任播弹性公网IP(Anycast EIP)](https://help.aliyun.com/document_detail/169284.html).

本 Module 支持创建以下资源:

* [任播弹性公网IP(Eipanycast_Anycast_Eip_Address)](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eipanycast_anycast_eip_address)
* [分配任播弹性公网IP(Eipanycast_Anycast_Eip_Address_Attachment)](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eipanycast_anycast_eip_address_attachment)

## 版本要求

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.131.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.131.0 |

## 用法

<div style="display: block;margin-bottom: 40px;"><div class="oics-button" style="float: right;position: absolute;margin-bottom: 10px;">
  <a href="https://api.aliyun.com/terraform?source=Module&activeTab=document&sourcePath=terraform-alicloud-modules%3A%3Aeip-anycast&spm=docs.m.terraform-alicloud-modules.eip-anycast" target="_blank">
    <img alt="Open in AliCloud" src="https://img.alicdn.com/imgextra/i1/O1CN01hjjqXv1uYUlY56FyX_!!6000000006049-55-tps-254-36.svg" style="max-height: 44px; max-width: 100%;">
  </a>
</div></div>

```hcl
provider "alicloud" {
  region = "cn-hangzhou"
}

provider "alicloud" {
  region = "cn-hongkong"
  alias = "backend"
}

data "alicloud_zones" "default" {
  provider = alicloud.backend
  available_resource_creation = "VSwitch"
}

data "alicloud_regions" "default" {
  provider = alicloud.backend
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


module "example" {
  source = "terraform-alicloud-modules/eip-anycast/alicloud"
  create = true
  eip_anycast_service_location = "international"
  eip_anycast_service_bind_instance_id = alicloud_slb.default.id
  eip_anycast_service_bind_instance_region_id = data.alicloud_regions.default.regions.0.id
}
```

提交问题
------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)