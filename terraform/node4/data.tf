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

data "vsphere_virtual_machine" "k3os-a" {
  name          = "k3os-a-template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "k3os-b" {
  name          = "k3os-b-template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "k3os-c" {
  name          = "k3os-c-template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "k3os-d" {
  name          = "k3os-d-template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "LAB"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
