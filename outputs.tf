output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.irsa.url
}

output "irsa_iam_roles_arn" {
  value = [
    module.iam_role_cert_manager.iam_role_arn
  ]
}

output "omni_backups_access_key_id" {
  value = aws_iam_access_key.omni.id
}

output "omni_backups_secret_access_key" {
  value     = aws_iam_access_key.omni.secret
  sensitive = true
}
