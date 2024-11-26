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

## Setup Azure Container Registry
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

output "acr_login_server" {
  value = azurerm_container_registry.ntx_devops_registries.login_server
}

output "acr_admin_username" {
  value     = azurerm_container_registry.ntx_devops_registries.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.ntx_devops_registries.admin_password
  sensitive = true
}

# Setup Azure Kubernetes Service
resource "azurerm_kubernetes_cluster" "ntx_aks" {
  name                = "ntx-aks"
  location            = azurerm_resource_group.ntx_devops_group.location
  resource_group_name = azurerm_resource_group.ntx_devops_group.name
  dns_prefix          = "ntxaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "test"
  }

  depends_on = [
    azurerm_container_registry.ntx_devops_registries
  ]

}

resource "azurerm_role_assignment" "ntx_aks_role" {
  principal_id                     = azurerm_kubernetes_cluster.ntx_aks.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.ntx_devops_registries.id
  skip_service_principal_aad_check = true
}

# Output for AKS name
output "aks_name" {
  value = azurerm_kubernetes_cluster.ntx_aks.name
}

# Output for AKS resource group
output "aks_resource_group" {
  value = azurerm_resource_group.ntx_devops_group.name
}
