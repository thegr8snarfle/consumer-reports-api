variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "handler" {
  description = "The Lambda function handler (e.g., main.handler)."
  type        = string
}

variable "runtime" {
  description = "The runtime for the Lambda function."
  type        = string
}

variable "s3_bucket_arn" {
  description = "S3 bucket ARN"
  type        = string
}

variable "s3_bucket__object_key" {
  description = "The S3 key/path for the Lambda deployment package."
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket name containing the lambda deployment package"
}