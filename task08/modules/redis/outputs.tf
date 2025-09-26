output "redis_hostname_secret_id" {
  value = azurerm_key_vault_secret.redis_hostname.id
}

output "redis_primary_key_secret_id" {
  value = azurerm_key_vault_secret.redis_primary_key.id
}

output "redis_hostname" {
  value = data.azurerm_redis_cache.existing.hostname
}

output "redis_primary_key" {
  sensitive = true
  value     = azurerm_key_vault_secret.redis_primary_key.value
}
