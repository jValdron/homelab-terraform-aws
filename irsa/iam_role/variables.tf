variable "name" {
  type = string
}
variable "service_account_name" {
  type = string
  default = null
}

variable "namespace" {
  type    = string
  default = null
}

variable "openid_provider_arn" {
  type = string
}

variable "issuer" {
  type = string
}

variable "inline_policy" {
  type = string
}
