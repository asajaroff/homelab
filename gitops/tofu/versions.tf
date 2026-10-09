terraform {
  required_version = ">= 1.6"

  required_providers {
    xenorchestra = {
      source  = "vatesfr/xenorchestra"
      version = "~> 0.31"
    }
  }
}

# Credentials come from XOA_USER and XOA_PASSWORD (or XOA_TOKEN).
provider "xenorchestra" {
  url = var.xoa_url

  # Self-signed XOA cert is common in a homelab.
  insecure = var.xoa_insecure
}
