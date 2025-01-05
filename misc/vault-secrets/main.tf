terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.3.0"
    }
  }
}
resource "vault_mount" "main" {
  for_each = var.secrets
  path     = each.key
  type     = "kv"
  options  = { version = "1" }
  description = each.key
}

variable "secrets" {
  default = {
    infra = {}
    roboshop-dev = {}
  }
}