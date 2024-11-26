terraform {
  backend "azurerm" {
    resource_group_name  = "ntxtfstate"
    storage_account_name = "ntxstfstateaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}