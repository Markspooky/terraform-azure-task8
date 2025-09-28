variable "name_prefix" {
  type        = string
  default     = "cmtr-zz733vvq-mod8"
  description = "Prefix used for naming all Azure resources to ensure uniqueness."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Azure region where the resources will be deployed."
}

variable "acr_sku" {
  type        = string
  description = "SKU (pricing tier) for the Azure Container Registry, e.g., Basic, Standard, or Premium."
}

variable "git_pat" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token (PAT) used for accessing private repositories or triggering ACR builds."
}

variable "creator_tag" {
  type        = string
  default     = "mark_nagy@epam.com"
  description = "Tag value used to identify the creator of the resources."
}

