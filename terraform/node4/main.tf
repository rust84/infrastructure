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

  num_cpus = 4
  memory   = 8192
  guest_id = "${data.vsphere_virtual_machine.k3os-a.guest_id}"

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
    client_device = true
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.k3os-a.id}"
  }
}

# resource "vsphere_virtual_machine" "k3os" {
#   count            = "1"
#   name             = "${var.virtual_machine_name_prefix}${count.index+4}"
#   resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
#   datastore_id     = "${data.vsphere_datastore.datastore.id}"
#
#   num_cpus = 4
#   memory   = 8192
#   guest_id = "${data.vsphere_virtual_machine.k3os.guest_id}"
#
#   network_interface {
#     network_id = "${data.vsphere_network.network.id}"
#   }
#
#   disk {
#     label = "disk0"
#     size  = 30
#   }
#
#   cdrom {
#     client_device = true
#   }
#
#   clone {
#     template_uuid = "${data.vsphere_virtual_machine.k3os.id}"
#   }
# }
