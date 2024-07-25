module "lambda" {
  source             = "./modules/lambda"
  source_path        = var.source_path
  function_name      = var.function_name
  role_name          = var.role_name
  runtime            = var.runtime
  api_deployment_arn = module.api.api_arn_output

}
module "api" {
  source      = "./modules/api"
  lambda_arn  = module.lambda.lambda_arn_output
  api_name    = var.api_name
  description = var.description
  method      = var.api_http_method
}

module "dynamodb" {
  source           = "./modules/dynamodb"
  table_name       = var.table_name
  billing_mode     = var.billing_mode
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  first_attribute  = var.first_attribute
  second_attribute = var.second_attribute 
}
module "netwoking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  azs                 = var.azs
  route_cidr          = var.route_cidr
  security_group_name = var.security_group_name
  description         = var.description_web
  vpc_tag             = var.vpc_tag
   lb_sg_id           = module.loadbalancer.lb_security_group_id_outputs
}

module "ec2" {
  source              = "./modules/ec2"
  instance_name       = var.instance_name
  instance_count      = var.instance_count
  ami                 = var.ami
  instance_type       = var.instance_type
  private_subnet_id_0 = module.netwoking.private_subnet_id_outputs_0
  #private_subnet_id_1= module.netwoking.private_subnet_id_outputs_1
  security_group_id   = module.netwoking.security_gp_outputs
  lb_tg_arn           = module.loadbalancer.lb_tg_arn_outputs
}
module "loadbalancer" {
  source       = "./modules/loadbalancer"
  lb_name      = var.lb_name
  lb_type      = var.lb_type
  lb_tag       = var.lb_tag
  lb_tg_name   = var.lb_tg_name
  lb_protocol  = var.lb_protocol
  lb_tg_tag    = var.lb_tg_tag
  lb_lst_type  = var.lb_lst_type
  lb_subnet_id = module.netwoking.subnet_id_outputs
  lb_subnet_id_1 = module.netwoking.subnet_id_outputs1
  lb_vpc_id    = module.netwoking.vpc_id_outputs

}
module "autoscaling" {
  source                    = "./modules/autoscaling"
  launch_configuration_name = var.autoscaling_group_name
  image_id                  = var.ami
  security_groups           = module.netwoking.security_gp_outputs
  instance_type             = var.instance_type
  subnet_id                 = module.netwoking.private_subnet_id_outputs_0
  autoscaling_group_name    = var.autoscaling_group_name
  target_group_arn          = module.loadbalancer.lb_tg_arn_outputs
  policy_name               = var.policy_name
  policy_type               = var.policy_type
  predefined_metric_type    = var.predefined_metric_type
  
}


