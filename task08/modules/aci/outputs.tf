output "aci_fqdn" {
  value = azurerm_container_group.this.fqdn
}
output "identity_id" {
  value = azurerm_user_assigned_identity.this.id
}
