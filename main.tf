#creating iam user
resource "aws_iam_user" "s3_user" {
    name = var.username
}

#creating s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
   bucket = "${var.env}-return-image-bucket"
}

#attaching policy
data "aws_iam_policy_document" "s3_access_doc" {
  # Bucket-level permissions (Listing and checking location)
  statement {
    sid    = "S3BucketLevelActions"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}"
    ]
  }

  # Object-level permissions (Read, Write, Delete contents)
  statement {
    sid    = "S3ObjectLevelActions"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*" # Grants access to all objects inside
    ]
  }
}
# 3. Attach the inline policy to the newly created user
resource "aws_iam_user_policy" "s3_access_policy" {
  name   = "S3ReadWriteDeleteAccess"
  user   = aws_iam_user.s3_user.name
  policy = data.aws_iam_policy_document.s3_access_doc.json
}


# Generate access key pair
resource "aws_iam_access_key" "s3_user_keys" {
  user = aws_iam_user.s3_user.name
}

