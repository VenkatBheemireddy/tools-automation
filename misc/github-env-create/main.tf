terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "project-setup-1"
    storage_account_name = "v82tfstates"
    container_name       = "github-env"
    key                  = "terraform.tfstate"

  }
}

# Configure the GitHub Provider
provider "github" {
  owner = "VenkatBheemireddyOrg"
}

data "github_user" "current" {
  username = "VenkatBheemireddy"
}

variable "repos" {
  default = ["roboshop-cart", "roboshop-catalogue", "roboshop-user", "roboshop-shipping", "roboshop-payment", "roboshop-frontend"]
}

resource "github_repository_environment" "dev" {
  count               = length(var.repos)
  environment         = "DEV"
  repository          = var.repos[count.index]
  prevent_self_review = false
}

resource "github_repository_environment" "qa" {
  count               = length(var.repos)
  environment         = "QA"
  repository          = var.repos[count.index]
  prevent_self_review = false
  reviewers {
    users = [data.github_user.current.id]
  }
}

resource "github_repository_environment" "uat" {
  count               = length(var.repos)
  environment         = "UAT"
  repository          = var.repos[count.index]
  prevent_self_review = false
  reviewers {
    users = [data.github_user.current.id]
  }
}

resource "github_repository_environment" "prod" {
  count               = length(var.repos)
  environment         = "PROD"
  repository          = var.repos[count.index]
  prevent_self_review = false
  reviewers {
    users = [data.github_user.current.id]
  }
}

