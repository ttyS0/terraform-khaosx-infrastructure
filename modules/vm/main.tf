variable "vm_hostname" {}
variable "vm_annotation" {}
variable "vm_num_cpus" {}
variable "vm_memory" {}
variable "vm_folder" {}
variable "vm_resource_pool" {}
variable "vm_datastore" {}
variable "vm_guestid" {}
variable "vm_scsitype" {}
variable "vm_template_uuid" {}

variable "vm_networks" {
  type = list(map(string))
}

variable "vm_disks" {
  type = list(map(string))
}

variable "vm_dns" {
  type = list(string)
  default = [
    "192.168.10.11",
    "192.168.10.10"
  ]
}

variable "vm_net_adapter" {
  default = "vmxnet3"
}

variable "vm_domain" {
  default = "khaosx.net"
}

variable "vm_gateway" {
  default = "192.168.10.1"
}

variable "vm_timezone" {
  default = "America/New_York"
}

variable "vm_netmask" {
  default = "24"
}

variable "vm_memory_reservation" {
  default = null
}


resource "vsphere_virtual_machine" "vm" {
  name             		= var.vm_hostname
  annotation			= var.vm_annotation
  resource_pool_id 		= var.vm_resource_pool
  datastore_id     		= var.vm_datastore
  num_cpus 				= var.vm_num_cpus
  memory   				= var.vm_memory
  memory_reservation    = var.vm_memory_reservation
  folder				= var.vm_folder
  guest_id 				= var.vm_guestid
  scsi_type 			= var.vm_scsitype

  dynamic "network_interface" {
    for_each = var.vm_networks

    content {
      network_id = vm_networks["network_id"]
      mac_address = vm_networks["mac_address"]
      adapter_type = var.vm_net_adapter
      use_static_mac = true
    }
  }

  dynamic "disk" {
    for_each = var.vm_disks
    content {
      label = vm_disks["label"]
      size = vm_disks["size"]
      eagerly_scrub = vm_disks["eagerly_scrub"]
      thin_provisioned = vm_disks["thin_provisioned"]
    }
  }


  clone {
    template_uuid 		= var.vm_template_uuid

    customize {
      linux_options {
        host_name 		= var.vm_hostname
        domain    		= var.vm_domain
        hw_clock_utc 	= true
        time_zone		= var.vm_timezone
      }

      dynamic "network_interface" {
        for_each = var.vm_networks

        content {
          ipv4_address = vm_networks["ipv4_address"]
          ipv4_netmask = var.vm_netmask
        }
      }

      ipv4_gateway    	= var.vm_gateway
      dns_server_list 	= var.vm_dns
      dns_suffix_list 	= [ var.vm_domain ]
    }
  }
}
