resource "b2_bucket" "surrealdb_backup_bucket" {
  bucket_name = var.backup_bucket_name
  bucket_type = "allPrivate"
}

resource "fly_app" "surrealdb_app" {
  name = var.fly_app_name
  org  = var.fly_org_name
}

resource "fly_ip" "surrealdb_ipv4" {
  app        = fly_app.surrealdb_app.name
  type       = "v4"
  depends_on = [fly_app.surrealdb_app]
}

resource "fly_ip" "surrealdb_ipv6" {
  app        = fly_app.surrealdb_app.name
  type       = "v6"
  depends_on = [fly_app.surrealdb_app]
}

resource "fly_cert" "surrealdb_cert" {
  app      = fly_app.surrealdb_app.name
  hostname = var.hostname
}

resource "fly_volume" "surrealdb_volume" {
  name       = "${replace(var.fly_app_name, "-", "_")}_volume_${var.fly_region}"
  app        = fly_app.surrealdb_app.name
  size       = 1 # In GB
  region     = var.fly_region
  depends_on = [fly_app.surrealdb_app]
}

resource "fly_machine" "surrealdb_machine" {
  app      = fly_app.surrealdb_app.name
  region   = var.fly_region
  name     = "${var.fly_app_name}-${var.fly_region}"
  image    = "krisswann/surrealdb:1.0.0-beta.8-v0"
  mounts = [
    {
      path   = "/data"
      volume = fly_volume.surrealdb_volume.id
    }
  ]
  env = {
    USER = var.root_username
    PASS = var.root_password
  }
  services = [
    {
      ports = [
        {
          port     = 443
          handlers = ["tls", "http"]
        },
        {
          port     = 80
          handlers = ["http"]
        }
      ]
      "protocol" : "tcp",
      "internal_port" : 8000
    },
  ]
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.surrealdb_app]
}
