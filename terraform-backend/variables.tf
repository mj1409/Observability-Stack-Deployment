variable "tfstate_bucket_name" {
  description = "Name of the s3 bucket to store Terraform state"
  type        = string
  default     = "observability-tfstate-bucket"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-locks"
}

variable "aws_region" {
  description = "AWS region to deploy the resources"
  type       = string
  default = "ap-south-1"
}