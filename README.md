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
#   CATALOGUE_HOST: catalogue
#   CATALOGUE_PORT: "8080"
#   USER_HOST: user
#   USER_PORT: "8080"
#   CART_HOST: cart
#   CART_PORT: "8080"
#   SHIPPING_HOST: shipping
#   SHIPPING_PORT: "8080"
#   PAYMENT_HOST: payment
#   PAYMENT_PORT: "8080"

        catalogue_endpoint = "http://catalogue-dev.azdevopsv82.online:8080"
        cart_endpoint = "http://cart-dev.azdevopsv82.online:8080"
        user_endpoint = "http://user-dev.azdevopsv82.online:8080"
        shipping_endpoint = "http://shipping-dev.azdevopsv82.online:8080"
        payment_endpoint = "http://payment-dev.azdevopsv82.online:8080"
        CATALOGUE_HOST = "catalogue-dev.azdevopsv82.online"
        CATALOGUE_PORT = "8080"
        USER_HOST      = "user-dev.azdevopsv82.online"
        USER_PORT      = "8080"
        CART_HOST      = "cart-dev.azdevopsv82.online"
        CART_PORT      = "8080"
        SHIPPING_HOST  = "shipping-dev.azdevopsv82.online"
        SHIPPING_PORT  = "8080"
        PAYMENT_HOST   = "payment-dev.azdevopsv82.online"
        PAYMENT_PORT   = "8080"
      }

      catalogue = {
        MONGO        = "true"
        MONGO_URL    = "mongodb://mongodb-dev.azdevopsv82.online:27017/catalogue"

        DB_TYPE      = "mongo"
        APP_GIT_URL  = "https://github.com/roboshop-devops-project-v3/catalogue"
        DB_HOST      = "mongodb-dev.azdevopsv82.online"
        SCHEMA_FILE  = "db/master-data.js"
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

      shipping = {
        CART_ENDPOINT  = "cart-dev.azdevopsv82.online:8080"
        DB_HOST        = "mysql-dev.azdevopsv82.online"
        DB_TYPE       = "mysql"
        APP_GIT_URL   = "https://github.com/roboshop-devops-project-v3/shipping"
        DB_HOST       = "mysql-dev.azdevopsv82.online"
        DB_USER       = "root"
        DB_PASS       = "RoboShop@1"
        MYSQL_ROOT_PASSWORD = "RoboShop@1"
      }

      payment = {
        CART_HOST = "cart-dev.azdevopsv82.online"
        CART_PORT = "8080"
        USER_HOST = "user-dev.azdevopsv82.online"
        USER_PORT = "8080"
        AMQP_HOST = "rabbitmq-dev.azdevopsv82.online"
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }

      mysql = {
        MYSQL_ROOT_PASSWORD = "RoboShop@1"
      }

      rabbitmq = {
        AMQP_USER = "roboshop"
        AMQP_PASS = "roboshop123"
      }
    }
}
}

