provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm" {
  count            = "1"
  name             = "terraform-test"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 1
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 50
  }

  cdrom {
    client_device = true
  }

  clone {
   template_uuid = "${data.vsphere_virtual_machine.template.id}"

   customize {
     linux_options {
       host_name = "${var.virtual_machine_name_prefix}${count.index}"
       domain    = "${var.virtual_machine_domain}"
     }
   }
 }
}
