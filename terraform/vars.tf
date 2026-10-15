variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "my_ip_cidr" {
  type        = string
  description = "my public ip address in CIDR format"
}