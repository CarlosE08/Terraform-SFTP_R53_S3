output "onlywrite_arn" {
  value = aws_iam_role.user_onlywrite.arn
  description = "value of the ARN for the onlywrite role"
}

output "admin_arn" {
  value = aws_iam_role.user_admin.arn
  description = "value of the ARN for the admin role"
}