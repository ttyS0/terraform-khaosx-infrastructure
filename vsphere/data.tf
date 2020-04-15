data "vsphere_datacenter" "dc" {
  name 				= var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          		= var.vsphere_datastore
  datacenter_id 		= data.vsphere_datacenter.dc.id
}

data "vsphere_network" "ProdNetwork" {
  name          		= var.vsphere_network
  datacenter_id 		= data.vsphere_datacenter.dc.id
}

data "vsphere_network" "SAN" {
  name          		= var.vsphere_network_san
  datacenter_id 		= data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "resource_pool" {
  name           		= var.vsphere_resource_pool
  datacenter_id  		= data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "small" {
  name					= "Ubuntu_18.04_Template_Small"
  datacenter_id			= data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "medium" {
  name					= "Ubuntu_18.04_Template_Medium"
  datacenter_id			= data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "large" {
  name          		= "Ubuntu_18.04_Template_Large"
  datacenter_id 		= data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "control" {
  name					= "Ubuntu_18.04_Template_Control"
  datacenter_id			= data.vsphere_datacenter.dc.id
}
