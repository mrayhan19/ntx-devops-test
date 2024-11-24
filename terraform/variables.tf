variable "azure_subscription_id" {
  description = "subscrption id azure"
  type = string
}

variable "azure_tenant_id" {
  description = "tenant id azure"
  type = string
}

variable "terraform_azure_client_id" {
  description = "azure terraform user subscription id"
  type = string
}

variable "terraform_azure_client_secret" {
  description = "azure terraform user subscription secret"
  type = string
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