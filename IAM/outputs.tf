output "iam_user_name" {
  value       = aws_iam_user.observability_user.name
}

output "access_key_id" {
  value     = aws_iam_access_key.access_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.access_key.secret
  sensitive = true
}