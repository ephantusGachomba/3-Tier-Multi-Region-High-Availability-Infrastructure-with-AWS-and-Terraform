/*
terraform {
  backend "s3" {
    bucket = "dev-state-file-new-day26"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "dev_dynamodb_table_name_new"
    encrypt = true
  }
}
*/