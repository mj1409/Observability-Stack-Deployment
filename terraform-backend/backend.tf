terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-example"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
