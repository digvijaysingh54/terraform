terraform {
 backend "s3" {
   bucket         = "bucket-to-store-tf-ststefiles"
   key            = "state/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
 }
}