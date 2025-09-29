output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.this.id
}
output "kube_admin_config" {
  value     = azurerm_kubernetes_cluster.this.kube_admin_config[0]
  sensitive = true
}
output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}
output "aks_kv_identity_id" {
  value = azurerm_kubernetes_cluster.this.identity[0].principal_id
}
