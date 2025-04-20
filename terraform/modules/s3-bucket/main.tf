resource "aws_s3_bucket" "lambda_artifacts" {
  bucket          = var.bucket_name
  tags            = var.tags
}

resource "aws_s3_object" "lambda_artifact" {
  bucket      = aws_s3_bucket.lambda_artifacts.id
  key         = var.lambda_zip_file_name
  source      = "../${var.lambda_zip_file_path}/${var.lambda_zip_file_name}"
  etag        = filemd5("../${var.lambda_zip_file_path}/${var.lambda_zip_file_name}")
}