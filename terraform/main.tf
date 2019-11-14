provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm" {
  count            = "4"
  name             = "${var.virtual_machine_name_prefix}${count.index+1}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 4096
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

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
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {

      linux_options {
        host_name = "${var.virtual_machine_name_prefix}${count.index+1}"
        domain    = "${var.virtual_machine_domain}"
      }

      network_interface {
        ipv4_address = "${cidrhost(var.virtual_machine_network_address, var.virtual_machine_ip_address_start + count.index)}"
        ipv4_netmask = "${element(split("/", var.virtual_machine_network_address), 1)}"
      }

      ipv4_gateway    = "${var.virtual_machine_gateway}"
      dns_suffix_list = ["${var.virtual_machine_domain}"]
      dns_server_list = ["192.168.1.86", "1.1.1.1"]
    }
  }
}
