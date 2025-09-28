variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group where resources will be deployed."
}

variable "location" {
  type        = string
  description = "The Azure region/location where the resources will be created."
}

variable "name_prefix" {
  type        = string
  description = "Prefix used for naming Azure resources to ensure uniqueness."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to Azure resources for organization."
}

variable "node_count" {
  type        = number
  description = "The number of nodes to provision in the AKS cluster."
}

variable "node_size" {
  type        = string
  description = "The size/type of the virtual machines for the AKS nodes (e.g., Standard_D2s_v3)."
}

variable "aci_identity_id" {
  type        = string
  description = "The resource ID of the Azure Container Instance (ACI) managed identity."
}

variable "keyvault_id" {
  type        = string
  description = "The resource ID of the Azure Key Vault instance."
}

variable "keyvault_name" {
  type        = string
  description = "The name of the Azure Key Vault instance."
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID."
}

variable "acr_id" {
  type        = string
  description = "The resource ID of the Azure Container Registry (ACR)."
}

variable "acr_login_server" {
  type        = string
  description = "The login server URL for the Azure Container Registry."
}
