module "vm" {
  for_each     = var.tools
  source       = "./vm-module"
  component    = each.key
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  port         = each.value["ports"]
  vm_size      = each.value["vm_size"]
  #role_definition_name = each.value["role_definition_name"]
}

variable "tools" {
  default = {

    vault = {
      vm_size = "Standard_B2s"
      ports = {
        vault = {
          name     = "vault"
          priority = 101
          port     = 8200
        }
      }
    }

  }
}

variable "ssh_username" {}
variable "ssh_password" {}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "d82tfstates"    # Change this to your storage account
    container_name       = "tools-tf-state" # This container needs to be created as a pre-requisite
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
  subscription_id = "9af0e83a-d3ee-4c3c-a244-3274a3457024" # Change it to your subscription id
}