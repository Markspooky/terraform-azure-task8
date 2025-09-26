resource "azurerm_container_registry" "this" {
  name                = var.name_prefix
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "${var.name_prefix}-build"
  container_registry_id = azurerm_container_registry.this.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = var.dockerfile_path
    context_path         = var.context_path
    context_access_token = var.git_pat
    image_names          = ["${var.image_name}:{{.Run.ID}}"]
  }

  depends_on = [azurerm_container_registry.this]
}

