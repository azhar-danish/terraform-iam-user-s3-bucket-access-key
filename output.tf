# Output the keys to your terminal so you can use them
output "s3_user" {
    value = aws_iam_user.s3_user.name
}

output "s3_bucket" {
    value = aws_s3_bucket.s3_bucket.bucket
}

output "iam_user_access_key_id" {
  description = "The AWS Access Key ID for the new user"
  value       = aws_iam_access_key.s3_user_keys.id
}

output "iam_user_secret_access_key" {
  description = "The AWS Secret Access Key (Keep this secure!)"
  value       = aws_iam_access_key.s3_user_keys.secret
  sensitive   = true # Hides it from standard console outputs
}