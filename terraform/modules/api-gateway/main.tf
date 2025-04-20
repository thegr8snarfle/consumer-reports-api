# Expose the Lambda via HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.project_prefix}-api"
  protocol_type = "HTTP"
  tags          = var.tags
}

resource "aws_lambda_permission" "apigw" {
  statement_id    = "AllowAPIGatewayInvoke"
  action          = "lambda:InvokeFunction"
  function_name   = var.lambda_function_name
  principal       = "apigateway.amazonaws.com"
  source_arn      = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_function_arn
}

resource "aws_apigatewayv2_route" "default" {
  api_id          = aws_apigatewayv2_api.http_api.id
  route_key       = "$default"
  target          = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id          = aws_apigatewayv2_api.http_api.id
  name            = "prod"
  auto_deploy     = true
  tags            = var.tags
}