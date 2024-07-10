data "aws_partition" "current" {}

locals {
  region      = "us-east-1"
  partition   = data.aws_partition.current.partition
}
