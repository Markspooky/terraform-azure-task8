resource "azurerm_resource_group" "main" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

module "keyvault" {
  source              = "./modules/keyvault"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = var.name_prefix
  tags                = local.tags
  tenant_id           = data.azurerm_client_config.current.tenant_id
  current_object_id   = data.azurerm_client_config.current.object_id
}

module "redis" {
  source              = "./modules/redis"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = var.name_prefix
  tags                = local.tags
  keyvault_id         = module.keyvault.keyvault_id
  keyvault_name       = module.keyvault.keyvault_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = local.acr_name
  tags                = local.tags
  git_pat             = var.git_pat
  dockerfile_path     = "Dockerfile"
  context_path        = "https://github.com/…?ref=main"
  image_name          = "${var.name_prefix}-app"
  sku                 = var.acr_sku
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = var.name_prefix
  tags                = local.tags
  node_count          = 1
  node_size           = "Standard_B2s"
  keyvault_id         = module.keyvault.keyvault_id
  keyvault_name       = module.keyvault.keyvault_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  acr_id              = module.acr.acr_id
  acr_login_server    = module.acr.acr_login_server
  aci_identity_id     = module.aci.identity_id
}

module "aci" {
  source              = "./modules/aci"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = var.name_prefix
  tags                = local.tags
  acr_login_server    = module.acr.acr_login_server
  acr_username        = module.acr.admin_username
  acr_password        = module.acr.admin_password
  image_name          = "${var.name_prefix}-app"
  image_tag           = "latest" # vagy valami változó
  keyvault_id         = module.keyvault.keyvault_id
  name                = "aci-container"

  secret_redis_hostname_id    = module.redis.redis_hostname_secret_id
  secret_redis_primary_key_id = module.redis.redis_primary_key_secret_id
  redis_hostname              = module.redis.redis_hostname
  redis_primary_key           = module.redis.redis_primary_key
}

data "azurerm_client_config" "current" {}

provider "kubernetes" {
  host                   = length(module.aks.kube_admin_config) > 0 ? module.aks.kube_admin_config[0].host : ""
  client_certificate     = length(module.aks.kube_admin_config) > 0 ? base64decode(module.aks.kube_admin_config[0].client_certificate) : ""
  client_key             = length(module.aks.kube_admin_config) > 0 ? base64decode(module.aks.kube_admin_config[0].client_key) : ""
  cluster_ca_certificate = length(module.aks.kube_admin_config) > 0 ? base64decode(module.aks.kube_admin_config[0].cluster_ca_certificate) : ""
}


provider "kubectl" {
  host                   = length(module.aks.kube_admin_config) > 0 ? module.aks.kube_admin_config[0].host : ""
  client_certificate     = length(module.aks.kube_admin_config) > 0 ? base64decode(module.aks.kube_admin_config[0].client_certificate) : ""
  client_key             = length(module.aks.kube_admin_config) > 0 ? base64decode(module.aks.kube_admin_config[0].client_key) : ""
  cluster_ca_certificate = length(module.aks.kube_admin_config) > 0 ? base64decode(module.aks.kube_admin_config[0].cluster_ca_certificate) : ""
}

resource "kubectl_manifest" "k8s_deploy" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = "${var.name_prefix}-app"
    image_tag        = "latest"
  })

  depends_on = [module.aks]
}

resource "kubectl_manifest" "k8s_secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_identity_id
    kv_name                    = module.keyvault.keyvault_name
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })

  depends_on = [module.aks, module.keyvault, module.redis]
}

resource "kubectl_manifest" "k8s_service" {
  yaml_body  = file("${path.module}/k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.k8s_deploy]
}
data "kubernetes_service" "redis_flask" {
  metadata {
    name      = "redis-flask-app-service"
    namespace = "default"
  }

  depends_on = [kubectl_manifest.k8s_service]
}
