variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group where resources will be deployed."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be used for naming resources to ensure uniqueness."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources."
}

variable "acr_login_server" {
  type        = string
  description = "The login server URL of the Azure Container Registry."
}

variable "acr_username" {
  type        = string
  description = "Username for accessing the Azure Container Registry."
}

variable "acr_password" {
  type        = string
  description = "Password for accessing the Azure Container Registry."
}

variable "image_name" {
  type        = string
  description = "The name of the container image to deploy."
}

variable "image_tag" {
  type        = string
  description = "The tag/version of the container image to deploy."
}

variable "keyvault_id" {
  type        = string
  description = "The resource ID of the Azure Key Vault."
}

variable "secret_redis_hostname_id" {
  type        = string
  description = "The ID of the Azure Key Vault secret storing the Redis hostname."
}

variable "secret_redis_primary_key_id" {
  type        = string
  description = "The ID of the Azure Key Vault secret storing the Redis primary key."
}

variable "redis_hostname" {
  type        = string
  description = "The hostname/address of the Redis instance."
}

variable "redis_primary_key" {
  type        = string
  description = "The primary access key for the Redis instance."
}

variable "name" {
  type        = string
  description = "General purpose name variable, typically used for naming resources."
}
