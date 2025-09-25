resource "azurerm_key_vault" "this" {
  name                            = "${var.name_prefix}-kv"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = "standard"
  purge_protection_enabled        = false
  soft_delete_enabled             = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enabled_for_deployment          = true

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = var.tenant_id
  object_id    = var.current_object_id

  secret_permissions = [
    "get",
    "list",
    "set",
    "delete"
  ]
}
