resource "aws_s3_bucket" "terraform-state" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Environment = "dev"
  }
  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform-state.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

