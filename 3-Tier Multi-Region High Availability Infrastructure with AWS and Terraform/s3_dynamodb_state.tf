/*
#step 1 : create s3 bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = "dev-state-file-new-day26"

    #prevent accidental deletion of s3
  lifecycle {
    prevent_destroy = true
  }
}

#step 2 : Enable versioning of s3 bucket
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

#step 3 : Secure bucket using server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#step 4 : Block all public access to s3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

#step 5 : create dynamodb table for locking 
resource "aws_dynamodb_table" "terraform_locks" {
  name = "dev_dynamodb_table_name_new"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
*/