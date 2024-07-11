resource "aws_s3_bucket" "omni" {
  bucket = var.omni_s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "omni" {
  bucket = aws_s3_bucket.omni.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "omni" {
  depends_on = [
    aws_s3_bucket_ownership_controls.omni,
  ]

  bucket = aws_s3_bucket.omni.id
  acl    = "private"
}

resource "aws_iam_user" "omni" {
  name = "omni-backups"
}

resource "aws_iam_access_key" "omni" {
  user = aws_iam_user.omni.name
}

data "aws_iam_policy_document" "omni" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = [
      aws_s3_bucket.omni.arn,
      "${aws_s3_bucket.omni.arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "omni" {
  name   = "omni-backups"
  user   = aws_iam_user.omni.name
  policy = data.aws_iam_policy_document.omni.json
}
