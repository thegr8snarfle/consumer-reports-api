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

#default route map
resource "aws_apigatewayv2_route" "default" {
  api_id          = aws_apigatewayv2_api.http_api.id
  route_key       = "$default"
  target          = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

#logging
resource "aws_cloudwatch_log_group" "http_api_logs" {
  name              = "/aws/http-api/${aws_apigatewayv2_api.http_api.id}"
  retention_in_days = 3
  tags              = var.tags
}

#state environment
resource "aws_apigatewayv2_stage" "prod" {
  api_id          = aws_apigatewayv2_api.http_api.id
  name            = "prod"
  auto_deploy     = true
  tags            = var.tags

    # Turn on execution logging & data trace
  default_route_settings {
    logging_level      = "ERROR"   # INFO | ERROR | OFF
    data_trace_enabled = true     # include request/response bodies
  }

  # Access logs: each request → one log line
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.http_api_logs.arn
    format = <<EOF
      $context.requestId $context.identity.sourceIp $context.requestTime "$context.httpMethod $context.resourcePath $context.protocol" $context.status $context.responseLength
    EOF
  }
}

