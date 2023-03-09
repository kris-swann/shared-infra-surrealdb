variable "backup_bucket_name" {
  type = string
}

variable "fly_org_name" {
  type = string
}

variable "fly_app_name" {
  type = string
}

variable "fly_region" {
  type = string
}

variable "hostname" {
  type = string
}

variable "root_username" {
  type   = string
  sensitive = true
}

variable "root_password" {
  type   = string
  sensitive = true
}
