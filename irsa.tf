resource "aws_s3_bucket" "oidc" {
  bucket = var.oidc_s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "oidc" {
  bucket = aws_s3_bucket.oidc.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "oidc" {
  bucket = aws_s3_bucket.oidc.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "oidc" {
  depends_on = [
    aws_s3_bucket_ownership_controls.oidc,
    aws_s3_bucket_public_access_block.oidc,
  ]

  bucket = aws_s3_bucket.oidc.id
  acl    = "public-read"
}

resource "aws_s3_object" "oidc_discovery" {
  bucket  = aws_s3_bucket.oidc.id
  key     = "/.well-known/openid-configuration"
  acl     = "public-read"
  source  = var.oidc_openid_configuration_filename
}

resource "aws_s3_object" "oidc_jwks" {
  bucket = aws_s3_bucket.oidc.id
  key    = "/.well-known/jwks.json"
  acl    = "public-read"
  source = var.oidc_jwks_filename
}

data "tls_certificate" "oidc" {
  url = "https://${aws_s3_bucket.oidc.bucket_regional_domain_name}"
}

resource "aws_iam_openid_connect_provider" "irsa" {
  url             = "https://${aws_s3_bucket.oidc.bucket_regional_domain_name}"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
}
