#=============================Lambda_Variable=========================####


variable "source_path" {
  type    = string
  default = "C:/Users/SinghD30/OneDrive - Vodafone Group/Desktop/FinalProject/dev/modules/lambda/lambda_function.py"
}
variable "function_name" {
  type    = string
  default = "timestamp_lambda"
}
variable "runtime" {
  type    = string
  default = "python3.9"
}

variable "role_name" {
  type    = string
  default = "lambda_role"
}
variable "lambda_arn" {
  type    = string
  default = null
}
variable "api_deployment_arn" {
  type    = string
  default = null
}


##=================================api_variable===============================##




variable "api_name" {
  type    = string
  default = "TimestampApi"

}
variable "description" {
  type    = string
  default = "API for timestamp insertion"
}
variable "api_http_method" {
  type    = string
  default = "GET"

}


####==================================dynamodb_variable========================#####



variable "table_name" {
  type = string
  default = "timestamp_tb"  
}
variable "billing_mode" {
  type = string
  default = "PROVISIONED"  
}
variable "read_capacity" {
  type = number
  default = 20  
}
variable "write_capacity" {
  type = number
  default = 20  
}
variable "first_attribute" {
  type = string
  default = "ID"  
}
variable "second_attribute" {
  type = string
  default = "timestamp"  
}



###======================================ec2_variable============================###

variable "instance_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = "Web-Server"
}
variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-0e872aee57663ae2d"
}
variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 2
}
variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}
variable "private_subnet_id_0" {
  description = "List of private subnet IDs"
  type        = list(string)
  default = null 
}
/*variable "private_subnet_id_1" {
  description = "List of private subnet IDs"
  type        = list(string)
  default = null 
}*/

variable "security_group_id" {
  description = "ID of existing security group whose rules we will manage"
  type        = string
  default     = null
}
variable "security_group_rds_id1" {
    type = string
    default = null
}



#=================================loadbalancer_variable==============================#



variable "lb_name" {
  type = string
  default = "Server-LoadBalancer"
}
variable "lb_subnet_id" {
  type = list(string)
  default = null
}
variable "lb_type" {
  type = string
  default = "application"
}
variable "lb_tag" {
  type = string
  default = "ServerAlb"
}
variable "lb_tg_name" {
  type = string
  default = "Server-TG"
}
variable "lb_protocol" {
  type = string
  default = "HTTP"
}
variable "lb_tg_tag" {
  type = string
  default = "Server-TG"
}
variable "lb_vpc_id" {
  type = string
  default = null
}
variable "lb_tg_arn" {
  type = string
  default = null
}
variable "lb_lst_type" {
  type = string
  default = "forward"
  
}
variable "lb_subnet_id_1" {
  type = string
  default = null 
}

variable "lb_sg_id" {
  type = string
  default = null 
}



###=========================autoscaling_variable===================####



variable "launch_configuration_name" {
  type = string
  default = "scaling_configuration"

}
variable "autoscaling_group_name" {
  type = string
  default = "Server_autoscaling"

}
variable "target_group_arn" {
  type = string
  default = null

}
variable "policy_name" {
  type = string
  default = "autoscaling-policy"

}
variable "policy_type" {
  type = string
  default = "TargetTrackingScaling"

}
variable "predefined_metric_type" {
  type = string
  default = "ASGAverageCPUUtilization"

}

####==========================networking_variable================###

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"  
}
variable "public_subnet_cidr" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
    type = list(string)
    default = [ "10.0.4.0/24","10.0.5.0/24" ]
}
variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}
variable "route_cidr" {
    type = string
    default = "0.0.0.0/0"  
}
variable "security_group_name" {
    type = string
    default = "web_security"
}
variable "description_web" {
    type = string
    default = "this s security group for web-server"
}
variable "vpc_tag" {
    type = string
    default = "timestamp_vpc"
  
}