terraform {
  required_version = ">= 1.6"

  required_providers {
    xenorchestra = {
      source  = "vatesfr/xenorchestra"
      version = "~> 0.31"
    }
  }
}
