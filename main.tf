terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

locals {
  generate_name = "${var.common_tags.Cliente}-${var.common_tags.Proyecto}-${terraform.workspace}"
}

module "iam" {
  source        = "./modules/IAM"
  common_tags   = var.common_tags
  generate_name = local.generate_name
  bucket_name   = module.s3.bucket_name
}

module "s3" {
  source        = "./modules/S3"
  common_tags   = var.common_tags
  generate_name = local.generate_name
  bucket_name   = var.bucket_name
}

module "sftp" {
  source        = "./modules/SFTP"
  common_tags   = var.common_tags
  generate_name = local.generate_name

  # Usuarios
  onlywrite_user = var.onlywrite_user
  admin_user     = var.admin_user

  # Claves SSH
  onlywrite_ssh_key = var.onlywrite_ssh_key
  admin_ssh_key     = var.admin_ssh_key

  # Roles
  onlywrite_arn = module.iam.onlywrite_arn
  admin_arn     = module.iam.admin_arn

  bucket_name      = module.s3.bucket_name
  hosted_zone_id   = module.route53.hosted_zone_id
  hosted_zone_name = module.route53.hosted_zone_name
}

module "route53" {
  source        = "./modules/Route53"
  common_tags   = var.common_tags
  generate_name = local.generate_name
  endpoint      = module.sftp.sftp_endpoint
  zone_name     = var.zone_name
}