provider "vsphere" {
  user           		= var.vsphere_user
  password       		= var.vsphere_password
  vsphere_server 		= var.vsphere_server
  allow_unverified_ssl	= true
}

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

resource "vsphere_folder" "parent" {
  path          = "Terraform Managed"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "prdfolder" {
  path          = "${vsphere_folder.parent.path}/Prod Servers"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}
  
resource "vsphere_folder" "toolsfolder" {
  path          = "${vsphere_folder.prdfolder.path}/Tools Servers"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "dnsfolder" {
  path          = "${vsphere_folder.prdfolder.path}/DNS-DHCP"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "dockerfolder" {
  path          = "${vsphere_folder.prdfolder.path}/Docker Hosts"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "dbfolder" {
  path          = "${vsphere_folder.prdfolder.path}/Database Servers"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "appfolder" {
  path          = "${vsphere_folder.prdfolder.path}/Application Servers"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}