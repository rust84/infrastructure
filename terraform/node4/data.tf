data "vsphere_datacenter" "dc" {
  name = "HomeLab"
}

data "vsphere_datastore" "datastore" {
  name          = "iSCSI-LUN1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network 20"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.template_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "k3os" {
  name          = "packer-vmware-iso"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "k3os-3" {
  name          = "k3s-3-template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "LAB"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}