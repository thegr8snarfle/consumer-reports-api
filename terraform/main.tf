terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"    # for example: any 4.50.x release
      # or "= 4.50.0"       # exactly 4.50.0
      # or ">= 4.50.0, < 5.0" # any 4.x ≥4.50.0
    }
  }

  # (optional) pin your Terraform CLI version as well
  required_version = ">= 1.3.0, < 2.0.0"
}

provider "aws" {
  region = var.aws_region
}

module "s3_lambda_artifacts" {
  source                  = "./modules/s3-bucket"
  bucket_name             = var.s3_artifacts_bucket_name
  project_prefix          = var.project_prefix
  lambda_zip_file_path    = var.lambda_zip_file_path
  lambda_zip_file_name    = var.lambda_zip_file_name
}

module "lambda_function" {
  source                    = "./modules/api-lambda"
  function_name             = var.lambda_function_name
  handler                   = var.lambda_handler
  runtime                   = var.lambda_runtime
  project_prefix            = var.project_prefix
  s3_bucket_name            = module.s3_lambda_artifacts.bucket_name
  s3_bucket__object_key     = module.s3_lambda_artifacts.bucket_key
  s3_bucket_arn             = module.s3_lambda_artifacts.bucket_arn
}