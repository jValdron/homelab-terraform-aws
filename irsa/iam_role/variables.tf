variable "name" {
  type = string
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
