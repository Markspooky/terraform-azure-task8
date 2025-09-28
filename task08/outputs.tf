output "aci_fqdn" {
  value       = module.aci.aci_fqdn
  description = "The fully qualified domain name of the Azure Container Instance."
}

output "aks_lb_ip" {
  value       = data.kubernetes_service.redis_flask.status[0].load_balancer[0].ingress[0].ip
  description = "The IP address of the AKS load balancer for the Redis Flask app service."
}
