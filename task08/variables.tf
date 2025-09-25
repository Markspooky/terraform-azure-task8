variable "name_prefix" {
  type    = string
  default = "cmtr-zz733vvq-mod8"
}
variable "location" {
  type    = string
  default = "westeurope"
}
variable "acr_sku" {
  type = string
}
variable "git_pat" {
  type      = string
  sensitive = true
}
variable "creator_tag" {
  type    = string
  default = "mark_nagy@epam.com"
}
