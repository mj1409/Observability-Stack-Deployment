variable "aws_region" {
  default = "ap-south-1"
}

variable "bucket_name" {
  default = "my-terraform-state-bucket-example"
}

variable "dynamodb_table_name" {
  default = "terraform-lock-table"
}
