module "vm" {
  for_each     = var.tools
  source       = "./vm-module"
  component    = each.key
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ports         = each.value["ports"]
  vm_size      = each.value["vm_size"]
  # role_definition_name = each.value["role_definition_name"]
}

variable "tools" {
  default = {

    vault = {
      # port = 8200
      # role_definition_name = null
      vm_size = "Standard_B2s"
      ports = {
        vault = {
          name     = "vault"
          priority = 101
          port     = 8200
        }
      }
    }

    github-runner = {
      port = 443
      #adding the below code for github-runner
      # role_definition_name = "Contributor"
      vm_size = "Standard_B2s"
      # adding the below code for ELK
      ports = {}
    }

    elasticsearch = {
      vm_size = "Standard_E2s_v3"
      ports = {
        elasticsearch = {
          name     = "elasticsearch"
          priority = 101
          port     = 9200
        }

        kibana = {
          name     = "kibana"
          priority = 102
          port     = 80
        }

        logstash = {
          name     = "logstash"
          priority = 103
          port     = 5044
        }
      }
    }

    # sonarqube = {
    #   port = 9000
    # }

    # jenkins = {
    #   port = 8080
    # }

    # jenkins-agent = {
    #   port = 8080
    # }

    prometheus = {
      port = 9090
    }

    prom-node = {
      port = 9100
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
