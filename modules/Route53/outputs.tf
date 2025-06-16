output "hosted_zone_id" {
  description = "ID de la Hosted Zone"
  value       = aws_route53_zone.sftp_zone.id
}

output "hosted_zone_name" {
  description = "ID de la Hosted Zone"
  value       = aws_route53_zone.sftp_zone.name
}

data "aws_route53_zone" "selected" {
  name         = aws_route53_zone.sftp_zone.name
  private_zone = false
}

output "route53_ns_record_values" {
  description = "Valores de los registros NS de la Hosted Zone"
  value       = data.aws_route53_zone.selected.name_servers
}