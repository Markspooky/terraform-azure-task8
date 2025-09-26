resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.name_prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.name_prefix}-aks-dns"

  default_node_pool {
    name         = "system"
    node_count   = var.node_count
    vm_size      = var.node_size
    os_disk_type = "Ephemeral"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  # skip_service_principal_aad_check = true  
  depends_on = [azurerm_kubernetes_cluster.this]
}


resource "azurerm_key_vault_access_policy" "aks_to_kv" {
  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_kubernetes_cluster.this.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List"
  ]

  depends_on = [azurerm_kubernetes_cluster.this]
}
