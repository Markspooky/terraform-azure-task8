output "acr_login_server" {
  value = azurerm_container_registry.this.login_server
}
output "acr_id" {
  value = azurerm_container_registry.this.id
}
output "admin_username" {
  value = azurerm_container_registry.this.admin_username
}

output "admin_password" {
  value = azurerm_container_registry.this.admin_password
}
