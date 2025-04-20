output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.lambda_artifacts.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.lambda_artifacts.arn
}

output "bucket_domain_name" {
  description = "The S3 bucket domain name"
  value       = aws_s3_bucket.lambda_artifacts.bucket_domain_name
}

output "bucket_key" {
  description = "The S3 bucket key"
  value       = aws_s3_object.lambda_artifact.key
}

output "bucket_prefix" {
  description = "Key/path of the S3 bucket"
  value       = aws_s3_bucket.lambda_artifacts.bucket_prefix
}

output "bucket_id" {
  description = "ID of the S3 bucket created"
  value       = aws_s3_bucket.lambda_artifacts.id
}