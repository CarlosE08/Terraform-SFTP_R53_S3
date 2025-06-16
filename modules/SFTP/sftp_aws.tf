
############################### Crteate SFTP Server ################################

resource "aws_transfer_server" "sftp_server" {
  identity_provider_type = "SERVICE_MANAGED"
  endpoint_type          = "PUBLIC"
  protocols              = ["SFTP"]
  tags = merge(var.common_tags, {
    Name = "SFTP-${var.generate_name}"
    Ambiente = "${terraform.workspace}"
    "transfer:customHostname"    = "sftp.${var.hosted_zone_name}" # Agregar dominio personalizado
    "transfer:route53HostedZoneId" = "/hostedzone/${var.hosted_zone_id}" # Agregar ID de la Hosted Zone
    # Me di cuenta que no se puede usar el ID de la Hosted Zone directamente, sino que se debe usar la ruta completa.
    # "transfer:customHostname" y "transfer:route53HostedZoneId" son necesarios para usar un dominio personalizado.
    # Esto se adjunta en etiquetas, no en el bloque de configuración, pues la consola asigna estas etiquetas automáticamente
    # al crear el servidor SFTP y unirlo a la Hosted Zone.
  })
}

############################### Create SFTP only-write user ################################

resource "aws_transfer_user" "onlywrite_user" {
  server_id      = aws_transfer_server.sftp_server.id
  user_name      = var.onlywrite_user
  role           = var.onlywrite_arn
  home_directory = "/${var.bucket_name}"
  tags = merge(var.common_tags, {
    #Name = "TF-${var.generate_name}"
    Ambiente = "${terraform.workspace}"
    #transfer:customHostname = "var.route53_hosted_zone_id"
  })
}

resource "aws_transfer_ssh_key" "onlywrite_ssh_key" {
  server_id = aws_transfer_server.sftp_server.id
  user_name = aws_transfer_user.onlywrite_user.user_name
  body      = var.onlywrite_ssh_key
}

############################### Create SFTP admin user ################################

resource "aws_transfer_user" "admin_user" {
  server_id      = aws_transfer_server.sftp_server.id
  user_name      = var.admin_user
  role           = var.admin_arn
  home_directory = "/${var.bucket_name}"
  tags = merge(var.common_tags, {
    #Name = "TF-${var.generate_name}"
    Ambiente = "${terraform.workspace}"
  })
}

resource "aws_transfer_ssh_key" "admin_ssh_key" {
  server_id = aws_transfer_server.sftp_server.id
  user_name = aws_transfer_user.admin_user.user_name
  body      = var.admin_ssh_key
}