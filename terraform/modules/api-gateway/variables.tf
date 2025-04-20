variable "project_prefix" {
  description = "Name of the S3 bucket prefix!"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "lambda_function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the function"
  type        = string
}