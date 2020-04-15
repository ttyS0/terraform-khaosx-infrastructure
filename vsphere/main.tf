provider "vsphere" {
  user           		= var.vsphere_user
  password       		= var.vsphere_password
  vsphere_server 		= var.vsphere_server
  allow_unverified_ssl	= true
}

## VMs

### Chromium
locals {
  chromium_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:8f:dc"
      ipv4_address = "192.168.10.32"
    }
  ]

  chromium_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.large.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.large.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.large.disks.0.thin_provisioned
    }
  ]
}

module "chromium" {
  source = "../modules/vm"
  vm_hostname = "chromium"
  vm_annotation = "Monitoring: Prometheus, Grafana"
  vm_num_cpus = "4"
  vm_memory = "8192"
  vm_networks = local.chromium_disks
  vm_disks = local.chromium_disks
  vm_folder = vsphere_folder.toolsfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.large.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.large.guest_id
  vm_scsitype = data.vsphere_virtual_machine.large.scsi_type
}

### Copper
locals {
  copper_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:8b:90"
      ipv4_address = "192.168.10.37"
    },
    {
      network_id = data.vsphere_network.SAN.id
      mac_address = "00:50:56:a9:c6:06"
      ipv4_address = "192.168.15.37"
    }
  ]

  copper_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.large.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.large.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.large.disks.0.thin_provisioned
    }
  ]
}

module "copper" {
  source = "../modules/vm"
  vm_hostname = "copper"
  vm_annotation = "Plex Server"
  vm_num_cpus = "4"
  vm_memory = "8192"
  vm_memory_reservation = "8192"
  vm_networks = local.copper_networks
  vm_disks = local.copper_disks
  vm_folder = vsphere_folder.appfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.large.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.large.guest_id
  vm_scsitype = data.vsphere_virtual_machine.large.scsi_type
}

### Iridium
locals {
  iridium_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:7c:08"
      ipv4_address = "192.168.10.36"
    },
    {
      network_id = data.vsphere_network.SAN.id
      mac_address = "00:50:56:a9:a7:9a"
      ipv4_address = "192.168.15.36"
    }
  ]
  iridium_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.small.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.small.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.small.disks.0.thin_provisioned
    }
  ]
}

module "iridium" {
  source = "../modules/vm"
  vm_hostname = "iridium"
  vm_annotation = "DNS/DHCP - Runs Unbound and dnsmasq"
  vm_num_cpus = "1"
  vm_memory = "2048"
  vm_networks = local.iridium_networks
  vm_disks = local.iridium_disks
  vm_folder = vsphere_folder.dnsfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.small.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.small.guest_id
  vm_scsitype = data.vsphere_virtual_machine.small.scsi_type
}

### Mercury
locals {
  mercury_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:48:63"
      ipv4_address = "192.168.10.38"
    },
    {
      network_id = data.vsphere_network.SAN.id
      mac_address = "00:50:56:a9:42:56"
      ipv4_address = "192.168.15.38"
    }
  ]

  mercury_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.medium.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.medium.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.medium.disks.0.thin_provisioned
    }
  ]
}

module "mercury" {
  source = "../modules/vm"
  vm_hostname = "mercury"
  vm_annotation = "Docker server 01 - MediaOps"
  vm_num_cpus = "4"
  vm_memory = "8192"
  vm_networks = local.mercury_networks
  vm_disks = local.mercury_disks
  vm_folder = vsphere_folder.dockerfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.medium.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.medium.guest_id
  vm_scsitype = data.vsphere_virtual_machine.medium.scsi_type
}

### Palladium
locals {
  palladium_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:ff:de"
      ipv4_address = "192.168.10.35"
    }
  ]
  palladium_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.large.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.large.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.large.disks.0.thin_provisioned
    }
  ]
}

module "palladium" {
  source = "../modules/vm"
  vm_hostname = "palladium"
  vm_annotation = "Database server - primary MariaDB"
  vm_num_cpus = "4"
  vm_memory = "8192"
  vm_networks = local.palladium_networks
  vm_disks = local.palladium_disks
  vm_folder = vsphere_folder.dbfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.large.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.large.guest_id
  vm_scsitype = data.vsphere_virtual_machine.large.scsi_type
}

### Silver
locals {
  silver_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:90:21"
      ipv4_address = "192.168.10.11"
    }
  ]

  silver_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.small.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.small.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.small.disks.0.thin_provisioned
    }
  ]

}
module "silver" {
  source = "../modules/vm"
  vm_hostname = "silver"
  vm_annotation = "Primary Pi-hole server"
  vm_num_cpus = "1"
  vm_memory = "2048"
  vm_networks = local.silver_networks
  vm_disks = local.silver_disks
  vm_folder = vsphere_folder.dnsfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.small.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.small.guest_id
  vm_scsitype = data.vsphere_virtual_machine.small.scsi_type
}

### Titanium
locals {
  titanium_networks = [
    {
      network_id = data.vsphere_network.ProdNetwork.id
      mac_address = "00:50:56:a9:a7:02"
      ipv4_address = "192.168.10.33"
    }
  ]

  titanium_disks = [
    {
      label = "disk0"
      size = data.vsphere_virtual_machine.control.disks.0.size
      eagerly_scrub = data.vsphere_virtual_machine.control.disks.0.eagerly_scrub
      thin_provisioned = data.vsphere_virtual_machine.control.disks.0.thin_provisioned
    }
  ]

}

module "titanium" {
  source = "../modules/vm"
  vm_hostname = "titanium"
  vm_annotation = "Primary tools server. Ansible, Prometheus, Grafana"
  vm_num_cpus = "1"
  vm_memory = "2048"
  vm_networks = local.titanium_networks
  vm_disks = local.titanium_disks
  vm_folder = vsphere_folder.toolsfolder.path
  vm_template_uuid = data.vsphere_virtual_machine.control.id
  vm_resource_pool = data.vsphere_resource_pool.resource_pool.id
  vm_datastore = data.vsphere_datastore.datastore.id
  vm_guestid = data.vsphere_virtual_machine.control.guest_id
  vm_scsitype = data.vsphere_virtual_machine.control.scsi_type
}
