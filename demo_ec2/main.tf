provider "aws" {
  region = "us-east-1"
  access_key = "AKIA5EO3XP"
  secret_key = "4edtVMsNVHWcOu"
}

module "ec2" {
    source = "./modules/ec2"
    ami    = var.ami
    instance_type = var.instance_type
    tags_name     = var.tags_name
}
