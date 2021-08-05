provider "null" {
}

resource "null_resource" "test" {
}

variable "s3_endpoint" {}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_force_path_style         = true
  endpoints {
    s3 = var.s3_endpoint
  }
}

resource "aws_s3_bucket" "test_create_bucket" {
  bucket = "test-create-bucket"
  acl    = "private"
}
