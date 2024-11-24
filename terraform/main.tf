terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.11.0"
    }
  }
}

provider "azurerm" {
#  # Configuration options
  subscription_id = var.azure_subscription_id
  client_id = var.terraform_azure_client_id
  client_secret = var.terraform_azure_client_secret
  tenant_id = var.azure_tenant_id
  features {}
}

resource "azurerm_resource_group" "ntx_devops_group" {
  name = var.azure_resource_group_name
  location = var.azure_resource_group_location
}

resource "azurerm_container_registry" "ntx_devops_registries" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.ntx_devops_group.name
  location            = azurerm_resource_group.ntx_devops_group.location
  sku                 = "Basic"
  admin_enabled       = true
  depends_on = [ azurerm_resource_group.ntx_devops_group ]
}

output "acr_name" {
  value = azurerm_container_registry.ntx_devops_registries.name
}

#output "acr_login_server" {
#  value = azurerm_container_registry.ntx_devops_registries.login_server
#}
#
#output "acr_admin_username" {
#  value = azurerm_container_registry.ntx_devops_registries.admin_username
#}
#
#output "acr_admin_password" {
#  value = azurerm_container_registry.ntx_devops_registries.admin_password
#  sensitive = true
#}
