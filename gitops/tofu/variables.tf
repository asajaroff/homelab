variable "xoa_url" {
  type        = string
  description = "XOA websocket URL, e.g. wss://xoa.lan."
}

variable "xoa_insecure" {
  type        = bool
  default     = false
  description = "Skip TLS verification of the XOA endpoint."
}

variable "vms" {
  type = map(object({
    pool_name            = string
    template_name        = string
    sr_name              = string
    network_name         = string
    cpus                 = optional(number, 2)
    memory_gb            = optional(number, 4)
    disk_gb              = optional(number, 20)
    cloud_config         = optional(string)
    cloud_network_config = optional(string)
    tags                 = optional(list(string), [])
  }))
  default     = {}
  description = "VMs to create, keyed by name."
}
