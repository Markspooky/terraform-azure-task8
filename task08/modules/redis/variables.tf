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
  description = "A map of tags to assign to Azure resources for organizational purposes."
}

variable "keyvault_id" {
  type        = string
  description = "The ID of the Azure Key Vault resource."
}

variable "keyvault_name" {
  type        = string
  description = "The name of the Azure Key Vault."
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID."
}
