output "sftp_endpoint" {
  value = aws_transfer_server.sftp_server.endpoint
}

output "sftp-admin_user" {
  value = aws_transfer_user.admin_user
}

output "sftp-onlywrite_user" {
  value = aws_transfer_user.onlywrite_user
}

# data "aws_route53_zone" "selected" {
#   name         = aws_route53_zone.sftp_zone.name  # Reemplaza con tu dominio
#   private_zone = false
# }

# output "route53_ns_record_values" {
#   description = "Valores de los registros NS de la Hosted Zone"
#   value       = data.aws_route53_zone.selected.name_servers
# }

