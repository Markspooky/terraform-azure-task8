variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "name_prefix" { type = string }
variable "tags" { type = map(string) }
variable "git_pat" { type = string }
variable "dockerfile_path" {
  type    = string
  default = "Dockerfile"
}
variable "context_path" { type = string }
variable "image_name" { type = string }
variable "sku" {
  type = string
}
