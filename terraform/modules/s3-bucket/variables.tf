variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "lambda_zip_file_path" {
  description = "Path to the lambda zip file"
  type        = string
}

variable "lambda_zip_file_name" {
  description = "Name of the lambda zip file"
  type        = string
}



