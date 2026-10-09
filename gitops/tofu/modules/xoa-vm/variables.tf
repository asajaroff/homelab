variable "name" {
  type        = string
  description = "VM name label."
}

variable "description" {
  type        = string
  default     = "Managed by OpenTofu"
  description = "VM description."
}

variable "pool_name" {
  type        = string
  description = "Name of the XCP-ng pool to place the VM in."
}

variable "template_name" {
  type        = string
  description = "Name label of the VM template to clone (e.g. a cloud-init enabled Ubuntu template)."
}

variable "sr_name" {
  type        = string
  description = "Name label of the storage repository for the disk."
}

variable "network_name" {
  type        = string
  description = "Name label of the network to attach the VM to."
}

variable "cpus" {
  type    = number
  default = 2
}

variable "memory_gb" {
  type    = number
  default = 4
}

variable "disk_gb" {
  type    = number
  default = 20
}

variable "cloud_config" {
  type        = string
  default     = null
  description = "Cloud-init user-data. Null skips cloud-init."
}

variable "cloud_network_config" {
  type        = string
  default     = null
  description = "Cloud-init network-config. Null uses DHCP."
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "auto_poweron" {
  type    = bool
  default = true
}
