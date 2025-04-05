resource "vault_mount" "main" {
  path        = var.kv_path
  type        = "kv"
  options     = { version = "1" }
  description = var.kv_path
}

resource "vault_kv_secret" "secret" {
  for_each   = var.secrets
  path       = "${var.kv_path}/${each.key}"
  data_json  = jsonencode(each.value)
}


