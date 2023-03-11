variable "backup_bucket_name" {
  type      = string
  sensitive = true
}

variable "fly_org_name" {
  type      = string
  sensitive = true
}

variable "fly_app_name" {
  type      = string
  sensitive = true
}

variable "fly_region" {
  type      = string
  sensitive = true
}

variable "hostname" {
  type      = string
  sensitive = true
}

variable "root_username" {
  type      = string
  sensitive = true
}

variable "root_password" {
  type      = string
  sensitive = true
}
