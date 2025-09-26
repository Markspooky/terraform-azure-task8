resource "azurerm_container_group" "this" {
  name                = "${var.name_prefix}-ci"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  dns_name_label      = "${var.name_prefix}-ci"

  container {
    name   = "app"
    image  = "${var.acr_login_server}/${var.image_name}:${var.image_tag}"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "true"
      REDIS_URL      = var.redis_hostname
      REDIS_PWD      = var.redis_primary_key
    }

    secure_environment_variables = {
      REDIS_URL = azurerm_key_vault_secret.redis_hostname.value
      REDIS_PWD = azurerm_key_vault_secret.redis_primary_key.value
    }


    image_registry_credential {
      server   = var.acr_login_server
      username = var.acr_username
      password = var.acr_password
    }
  }

  ip_address_type = "Public"
  ports {
    port     = 8080
    protocol = "TCP"
  }

  tags = var.tags
}
resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.name}-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}
