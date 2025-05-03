module "vm" {
  for_each     = var.tools
  source       = "./vm-module"
  component    = each.key
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  port         = each.value["port"]
}

variable "tools" {
  default = {

    vault = {
      port = 8200
    }
    github-runner = {
      port = 443
    }
  }
}

variable "ssh_username" {}
variable "ssh_password" {}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "v82tfstates"    # Change this to your storage account
    container_name       = "tools-tf-state" # This container needs to be created as a pre-requisite
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
  subscription_id = "9af0e83a-d3ee-4c3c-a244-3274a3457024" # Change it to your subscription id
}