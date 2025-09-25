output "aci_fqdn" {
  value = module.aci.aci_fqdn
}
output "aks_lb_ip" {
  value = kubectl_manifest.k8s_service.status[0].load_balancer[0].ingress[0].ip
}
