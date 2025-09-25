locals {
  rg_name       = "${var.name_prefix}-rg"
  redis_name    = "${var.name_prefix}-redis"
  keyvault_name = "${var.name_prefix}-kv"
  aks_name      = "${var.name_prefix}-aks"
  acr_name      = replace(var.name_prefix, "-", "")
  aci_name      = "${var.name_prefix}-ci"
  tags = {
    Creator = var.creator_tag
  }
}
