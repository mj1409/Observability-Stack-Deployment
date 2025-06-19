bucket         = "observability-tfstate-bucket"
key            = "global/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-locks"
encrypt        = true
