provider "null" {
}

resource "null_resource" "test" {
}

resource "aws_s3_bucket" "test_create_bucket" {
  bucket = "test-create-bucket"
  acl    = "private"
}
