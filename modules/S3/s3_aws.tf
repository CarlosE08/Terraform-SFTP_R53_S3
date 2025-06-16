resource "aws_s3_bucket" "sftp_bucket" {
  bucket = var.bucket_name

  tags = merge(var.common_tags, {
    Ambiente = "${terraform.workspace}"
  })
}