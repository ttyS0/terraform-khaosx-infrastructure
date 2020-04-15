variable "vsphere_user" {
  description	= "User name for accessing vsphere environment"
  type    		= string
  default		= ""
}

variable "vsphere_password" {
  description	= "Password for accessing vsphere environment"
  type    = string
  default		= ""
}

variable "vsphere_server" {
  description	= "Primary vsphere server"
  type    = string
  default		= ""
}

variable "vsphere_datacenter" {
  description	= "Primary vsphere datacenter"
  type    = string
  default		= ""
}

variable "vsphere_datastore" {
  description	= "Primary vsphere datastore"
  type    = string
  default		= ""
}

variable "vsphere_network" {
  description	= "Primary network name"
  type    = string
  default		= ""
}

variable "vsphere_network_san" {
  description	= "SAN Network name"
  type    = string
  default		= ""
}

variable "vsphere_resource_pool" {
  description	= "Primary vsphere resource pool"
  type    = string
  default		= ""
}