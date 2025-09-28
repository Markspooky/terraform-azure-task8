variable "resource_group_name" {
  type        = string
  description = "The name of the Azure Resource Group where resources will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed."
}

variable "name_prefix" {
  type        = string
  description = "Prefix to use for naming resources to ensure uniqueness."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to resources."
}

variable "git_pat" {
  type        = string
  description = "Personal Access Token (PAT) for authenticating with GitHub."
  sensitive   = true
}

variable "dockerfile_path" {
  type        = string
  description = "Path to the Dockerfile used for building the container image."
  default     = "Dockerfile"
}

variable "context_path" {
  type        = string
  description = "The build context path or URL for the Docker build."
}

variable "image_name" {
  type        = string
  description = "Name of the Docker container image."
}

variable "sku" {
  type        = string
  description = "SKU or pricing tier for the Azure resource (e.g., Basic, Standard)."
}
