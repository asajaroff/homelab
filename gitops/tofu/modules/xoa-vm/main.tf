data "xenorchestra_pool" "this" {
  name_label = var.pool_name
}

data "xenorchestra_template" "this" {
  name_label = var.template_name
  pool_id    = data.xenorchestra_pool.this.id
}

data "xenorchestra_sr" "this" {
  name_label = var.sr_name
  pool_id    = data.xenorchestra_pool.this.id
}

data "xenorchestra_network" "this" {
  name_label = var.network_name
  pool_id    = data.xenorchestra_pool.this.id
}

resource "xenorchestra_vm" "this" {
  name_label           = var.name
  name_description     = var.description
  template             = data.xenorchestra_template.this.id
  cpus                 = var.cpus
  memory_max           = var.memory_gb * 1024 * 1024 * 1024
  auto_poweron         = var.auto_poweron
  cloud_config         = var.cloud_config
  cloud_network_config = var.cloud_network_config
  tags                 = var.tags

  network {
    network_id = data.xenorchestra_network.this.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.this.id
    name_label = "${var.name}-root"
    size       = var.disk_gb * 1024 * 1024 * 1024
  }
}
