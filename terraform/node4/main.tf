provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "k3os-a" {
  name             = "${var.virtual_machine_name_prefix}-a"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus         = 4
  memory           = 8192
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }
  disk {
    label = "disk0"
    size  = 64
  }
  # disk {
  #   label = "disk1"
  #   size  = 300
  #   thin_provisioned = true
  #   unit_number = 1
  # }
  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = "ISOs/k3os-a.iso"
  }
}

resource "vsphere_virtual_machine" "k3os-b" {
  name             = "${var.virtual_machine_name_prefix}-b"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus         = 4
  memory           = 8192
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }
  disk {
    label = "disk0"
    size  = 64
  }
  disk {
    label = "disk1"
    size  = 300
    thin_provisioned = true
    unit_number = 1
  }
  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = "ISOs/k3os-b.iso"
  }
}

resource "vsphere_virtual_machine" "k3os-c" {
  name             = "${var.virtual_machine_name_prefix}-c"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus         = 4
  memory           = 8192
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }
  disk {
    label = "disk0"
    size  = 64
  }
  disk {
    label = "disk1"
    size  = 300
    thin_provisioned = true
    unit_number = 1
  }
  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = "ISOs/k3os-c.iso"
  }
}

resource "vsphere_virtual_machine" "k3os-d" {
  name             = "${var.virtual_machine_name_prefix}-d"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  num_cpus         = 4
  memory           = 8192
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }
  disk {
    label = "disk0"
    size  = 64
  }
  disk {
    label = "disk1"
    size  = 300
    thin_provisioned = true
    unit_number = 1
  }
  cdrom {
    datastore_id = "${data.vsphere_datastore.datastore.id}"
    path         = "ISOs/k3os-d.iso"
  }
}
