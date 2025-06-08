terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-example"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
