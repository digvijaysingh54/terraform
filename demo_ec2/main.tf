

module "ec2" {
    source = "./modules/ec2"
    ami    = var.ami
    instance_type = var.instance_type
    tags_name     = var.tags_name
}