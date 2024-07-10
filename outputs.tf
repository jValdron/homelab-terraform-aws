output "oidc_provider_url" {
  value = aws_iam_openid_connect_provider.irsa.url
}

output "irsa_iam_roles_arn" {
  value = [
    module.iam_role_cert_manager.iam_role_arn
  ]
}
