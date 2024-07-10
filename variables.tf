variable "oidc_s3_bucket_name" {
  description = "Name of a S3 bucket for the OIDC endpoint"
}

variable "oidc_openid_configuration_filename" {
  description = "Filename of openid-configuration"
}

variable "oidc_jwks_filename" {
  description = "Filename of OIDC JWKS"
}
