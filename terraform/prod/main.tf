provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

#########
# Master A
#########
resource "vsphere_virtual_machine" "master_a" {
  name             = "${var.virtual_machine_name_prefix}a"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ssd.id

  num_cpus = 4
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 100
    thin_provisioned = true
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {

      linux_options {
        host_name = "${var.virtual_machine_name_prefix}a"
        domain    = var.virtual_machine_domain
      }

      network_interface {
        ipv4_address = cidrhost(var.virtual_machine_network_address, var.virtual_machine_ip_address_start + 0)
        ipv4_netmask = element(split("/", var.virtual_machine_network_address), 1)
      }

      ipv4_gateway    = var.virtual_machine_gateway
      dns_suffix_list = [var.virtual_machine_domain]
      dns_server_list = ["192.168.1.86", "1.1.1.1"]
    }
  }
}

#########
# Node B
#########
resource "vsphere_virtual_machine" "node_b" {
  name             = "${var.virtual_machine_name_prefix}b"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.nvme.id

  num_cpus = 4
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 100
    thin_provisioned = true
  }

  disk {
    label = "disk1"
    size  = 300
    unit_number = 1
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {

      linux_options {
        host_name = "${var.virtual_machine_name_prefix}b"
        domain    = var.virtual_machine_domain
      }

      network_interface {
        ipv4_address = cidrhost(var.virtual_machine_network_address, var.virtual_machine_ip_address_start + 1)
        ipv4_netmask = element(split("/", var.virtual_machine_network_address), 1)
      }

      ipv4_gateway    = var.virtual_machine_gateway
      dns_suffix_list = [var.virtual_machine_domain]
      dns_server_list = ["192.168.1.86", "1.1.1.1"]
    }
  }
}

#########
# Node C
#########
resource "vsphere_virtual_machine" "node_c" {
  name             = "${var.virtual_machine_name_prefix}c"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.nvme.id

  num_cpus = 4
  memory   = 8192
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 100
    thin_provisioned = true
  }

  disk {
    label = "disk1"
    size  = 300
    unit_number = 1
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {

      linux_options {
        host_name = "${var.virtual_machine_name_prefix}c"
        domain    = var.virtual_machine_domain
      }

      network_interface {
        ipv4_address = cidrhost(var.virtual_machine_network_address, var.virtual_machine_ip_address_start + 2)
        ipv4_netmask = element(split("/", var.virtual_machine_network_address), 1)
      }

      ipv4_gateway    = var.virtual_machine_gateway
      dns_suffix_list = [var.virtual_machine_domain]
      dns_server_list = ["192.168.1.86", "1.1.1.1"]
    }
  }
}

#########
# Node D
#########
resource "vsphere_virtual_machine" "node_d" {
  name             = "${var.virtual_machine_name_prefix}d"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.nvme2.id

  num_cpus = 4
  memory   = 16384
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 100
    thin_provisioned = true
  }

  disk {
    label = "disk1"
    size  = 300
    unit_number = 1
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {

      linux_options {
        host_name = "${var.virtual_machine_name_prefix}d"
        domain    = var.virtual_machine_domain
      }

      network_interface {
        ipv4_address = cidrhost(var.virtual_machine_network_address, var.virtual_machine_ip_address_start + 3)
        ipv4_netmask = element(split("/", var.virtual_machine_network_address), 1)
      }

      ipv4_gateway    = var.virtual_machine_gateway
      dns_suffix_list = [var.virtual_machine_domain]
      dns_server_list = ["192.168.1.86", "1.1.1.1"]
    }
  }
}