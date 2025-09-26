resource "azurerm_redis_cache" "this" {
  name                = "${var.name_prefix}-redis"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 2
  family              = "C"
  sku_name            = "Basic"
  minimum_tls_version = "1.2"

  tags = var.tags

  redis_configuration {
    enable_non_ssl_port = false
  }
}

data "azurerm_redis_cache" "existing" {
  name                = azurerm_redis_cache.this.name
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_redis_cache.this]
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = data.azurerm_redis_cache.existing.hostname
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = "redis-primary-key"
  value        = data.azurerm_redis_cache.existing.primary_access_key
  key_vault_id = var.keyvault_id
}

