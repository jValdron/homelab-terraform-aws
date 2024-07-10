module "iam_role_cert_manager" {
  source = "./irsa/iam_role"

  name                = "cert-manager"
  openid_provider_arn = aws_iam_openid_connect_provider.irsa.arn
  issuer              = aws_s3_bucket.oidc.bucket_regional_domain_name
  inline_policy       = data.aws_iam_policy_document.cert_manager.json
}

data "aws_iam_policy_document" "cert_manager" {
  statement {
    actions   = ["route53:GetChange"]
    resources = ["arn:${local.partition}:route53:::change/*"]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]

    resources = [
      aws_route53_zone.valdron_ca.arn
    ]
  }

  statement {
    actions   = ["route53:ListHostedZonesByName"]
    resources = ["*"]
  }
}

module "iam_role_external_dns" {
  source = "./irsa/iam_role"

  name                = "external-dns"
  openid_provider_arn = aws_iam_openid_connect_provider.irsa.arn
  issuer              = aws_s3_bucket.oidc.bucket_regional_domain_name
  inline_policy       = data.aws_iam_policy_document.external_dns.json
}

data "aws_iam_policy_document" "external_dns" {
  statement {
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = [
      aws_route53_zone.valdron_ca.arn
    ]
  }

  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
    ]

    resources = ["*"]
  }
}
