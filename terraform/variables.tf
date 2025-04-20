variable "aws_region" {
  description = "AWS region to deploy the Lambda function."
  type        = string
}

variable "project_prefix" {
  description = "Consumer Reports"
  default     = "cr"
}

variable "lambda_function_name" {
  description = "The name to assign to the Lambda function."
  type        = string
}

variable "lambda_handler" {
  description = "The handler entrypoint for the Lambda function (e.g., main.handler)."
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function."
  type        = string
  default     = "python3.9"
}

variable "lambda_zip_file_path" {
  description = "Path of the lambda build artifact file on s3."
  type        = string
}

variable "lambda_zip_file_name" {
  description = "Name of the lambda build artifact file on s3."
  type        = string
}

variable "s3_artifacts_bucket_name" {
  description = "The name for the artifacts S3 bucket"
  type        = string
}

variable "openai_api_key" {
  description = "The auth token for the openai API."
  type        = string
}

variable "tags" {
  description = "The tags that go on all these resources"
  type        = map(string)
}