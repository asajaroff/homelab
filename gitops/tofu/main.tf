module "vm" {
  source   = "./modules/xoa-vm"
  for_each = var.vms

  name                 = each.key
  pool_name            = each.value.pool_name
  template_name        = each.value.template_name
  sr_name              = each.value.sr_name
  network_name         = each.value.network_name
  cpus                 = each.value.cpus
  memory_gb            = each.value.memory_gb
  disk_gb              = each.value.disk_gb
  cloud_config         = each.value.cloud_config
  cloud_network_config = each.value.cloud_network_config
  tags                 = each.value.tags
}

output "vm_ips" {
  value = { for k, m in module.vm : k => m.ipv4_addresses }
}
