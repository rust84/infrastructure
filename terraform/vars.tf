variable "vsphere_user" {
  type = "string"
}

variable "vsphere_password" {
  type = "string"
}

variable "vsphere_server" {
  type = "string"
}

variable "template_name" {
  default = "Ubuntu1810Template"
}

variable "virtual_machine_name_prefix" {
  default = "k3s-node-"
}

variable "virtual_machine_domain" {
  type = "string"
}

// The network address for the virtual machines, in the form of 10.0.0.0/24.
variable "virtual_machine_network_address" {
  type = "string"
}

variable "virtual_machine_ip_address_start" {
  default = "100"
}

// The default gateway for the network the virtual machines reside in.
variable "virtual_machine_gateway" {
  type = "string"
}

// The DNS servers for the network the virtual machines reside in.
//variable "virtual_machine_dns_servers" {
//  type = list(string)
//}
