output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = module.lambda_function.lambda_function_arn
}

output "http_api_uri" {
  description = "The URI of the new http api."
  value       = module.api_gateway.http_api_uri
}