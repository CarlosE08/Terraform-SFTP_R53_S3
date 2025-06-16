# Variables definition
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}

# Nombre de la Hosted zone y del bucket S3
variable "bucket_name" {}
variable "zone_name" {}

# Usuarios
variable "onlywrite_user" {}
variable "admin_user" {}

# Claves SSH
variable "onlywrite_ssh_key" {}
variable "admin_ssh_key" {}

variable "common_tags" {
  description = "Etiquetas comunes para todos los recursos"
  type = object({
    Owner    = string
    Cliente  = string
    Proyecto = string
    Contacto = string
    #ID-Proyecto  = string
    #environment = string
  })
  default = {
    Owner    = "Carlos Escobar"
    Cliente  = "Test"
    Proyecto = "Test"
    Contacto = "Prueba"
  }
}