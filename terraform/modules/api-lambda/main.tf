data "aws_iam_policy_document" "lambda_s3_bucket_access" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["${var.s3_bucket_arn}/*"]
  }
}

data "aws_iam_policy_document" "assume_lambda_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions     = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_s3_policy" {
  name = "s3_${var.function_name}_access_policy"
  description = "Policy granting access for the lambda to the S3 bucket."
  policy = data.aws_iam_policy_document.lambda_s3_bucket_access.json
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda_role_policy.json
  tags = { //todo
    tag-key = "consumer-reports"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda" {
  function_name   = var.function_name
  s3_bucket       = var.s3_bucket_name
  s3_key          = var.s3_bucket__object_key
  handler         = var.handler
  runtime         = var.runtime
  role            = aws_iam_role.lambda_role.arn
  tags = { //todo
    tag-key = "consumer-reports"
  }
}