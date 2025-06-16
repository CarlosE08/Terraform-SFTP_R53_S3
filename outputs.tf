output "sftp_endpoint" {
  value = module.sftp.sftp_endpoint
}

output "sftp-admin_user" {
  value = module.sftp.sftp-admin_user
}

output "sftp-onlywrite_user" {
  value = module.sftp.sftp-onlywrite_user
}

output "route53_ns_record_values" {
  description = "Valores de los registros de la Hosted Zone desde el módulo SFTP"
  value       = module.route53.route53_ns_record_values
}
