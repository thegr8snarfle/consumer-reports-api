output "http_api_uri" {
  value = aws_apigatewayv2_stage.prod.invoke_url
}