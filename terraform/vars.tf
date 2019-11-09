variable "vsphere_user" {
  default = ""
}
variable "vsphere_password" {
  default = ""
}
variable "vsphere_server" {
  default = ""
}
variable "template_name" {
  default = "Ubuntu1810Template"
}
variable "virtual_machine_name_prefix" {
  default = "k3s-node-"
}
variable "virtual_machine_domain" {
  default = "our.house"
}
