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
