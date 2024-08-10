
resource "aws_iam_role" "this" {
  name = var.name

  assume_role_policy    = data.aws_iam_policy_document.assume_policy.json
  force_detach_policies = true

  inline_policy {
    name   = var.name
    policy = var.inline_policy
  }
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.openid_provider_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.issuer}:sub"

      values = coalesce(var.service_accounts, [
        "system:serviceaccount:${coalesce(var.namespace, var.name)}:${coalesce(var.service_account_name, var.name)}",
      ])
    }
  }
}
