module "create-secrets" {
  for_each = var.secrets
  source   = "./create-secrets"
  kv_path  = each.key
  secrets  = each.value
}

variable "secrets" {
  default = {
    infra = {
      ssh = {
        admin_username = "roboshop-ansible",
        admin_password = "DevOps@123456"
      }
    }
    roboshop-dev = {
      frontend = {
        catalogue_endpoint = "http://catalogue-dev.azdevopsv82.online:8080"
        cart_endpoint = "http://cart-dev.azdevopsv82.online:8080"
        user_endpoint = "http://user-dev.azdevopsv82.online:8080"
        shipping_endpoint = "http://shipping-dev.azdevopsv82.online:8080"
        payment_endpoint = "http://payment-dev.azdevopsv82.online:8080"
      }
      catalogue = {
        MONGO     = "true"
        MONGO_URL = "mongodb://mongodb-dev.azdevopsv82.online:27017/catalogue"
      }
      user = {
        MONGO     = "true"
        REDIS_URL = "redis://redis-dev.azdevopsv82.online:6379"
        MONGO_URL = "mongodb://mongodb-dev.azdevopsv82.online:27017/users"
      }
      cart = {
        REDIS_HOST     = "redis-dev.azdevopsv82.online"
        CATALOGUE_HOST = "catalogue-dev.azdevopsv82.online"
        CATALOGUE_PORT = "8080"
      }
    }
  }
}


