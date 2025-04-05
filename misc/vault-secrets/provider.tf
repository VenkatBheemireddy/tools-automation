provider "vault" {
  address = "http://vault-internal.azdevopsv82.online:8200"
  token   = var.token
}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "v82tfstates"     # Change this to your storage account
    container_name       = "vault-tf-states" # This container needs to be created as a pre-requisite
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9af0e83a-d3ee-4c3c-a244-3274a3457024" # Change it to your subscription id
}

variable "token" {}









