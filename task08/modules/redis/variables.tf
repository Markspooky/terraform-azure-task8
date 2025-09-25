variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "keyvault_id" {
  type = string
}
variable "keyvault_name" {
  type = string
}
variable "tenant_id" {
  type = string
}
