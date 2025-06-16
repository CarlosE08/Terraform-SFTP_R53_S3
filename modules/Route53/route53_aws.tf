resource "aws_route53_zone" "sftp_zone" {
  name = var.zone_name
  tags = merge(var.common_tags, {
    Ambiente = "${terraform.workspace}"
  })
}

resource "aws_route53_record" "sftp_dns" {
  zone_id = aws_route53_zone.sftp_zone.id
  name    = "sftp.${aws_route53_zone.sftp_zone.name}" # Subdominio para el servidor SFTP
  type    = "CNAME"
  ttl     = 300
  records = [var.endpoint] # Endpoint del servidor SFTP
}
