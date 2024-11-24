variable "azure_subscription_id" {
  description = "azure resource group name"
  type = string
  sensitive = true
}

variable "terraform_azure_client_id" {
  description = "client id untuk terraform"
  type = string
  sensitive = true
}

variable "terraform_azure_client_secret" {
  description = "client secret untuk terraform"
  type = string
  sensitive = true
}

variable "azure_tenant_id" {
  description = "tenant id untuk terraform"
  type = string
  sensitive = true
}

variable "azure_resource_group_name" {
  description = "azure resource group name"
  type = string
}

variable "azure_resource_group_location" {
  description = "azure resource group location"
  type = string
}

variable "acr_name" {
  description = "nama untuk Azure Container Registries"
  type = string
}