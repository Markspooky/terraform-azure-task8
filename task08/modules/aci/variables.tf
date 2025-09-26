variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name_prefix" { type = string }
variable "tags" { type = map(string) }
variable "acr_login_server" { type = string }
variable "acr_username" { type = string }
variable "acr_password" { type = string }
variable "image_name" { type = string }
variable "image_tag" { type = string }
variable "keyvault_id" { type = string }
variable "secret_redis_hostname_id" { type = string }
variable "secret_redis_primary_key_id" { type = string }
variable "redis_hostname" {
  type = string
}

variable "redis_primary_key" {
  type = string
}
variable "name" {
  type = string
}
