provider "aws" {
  region = local.region
  default_tags {
    tags = {
      Repository = "https://github.com/jValdron/homelab-terraform-aws/"
      Terraform  = "true"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }

  backend "s3" {
    bucket = "valdron-homelab-terraform-aws-state"
    key    = "homelab"
    region = "us-east-1"
  }
}
