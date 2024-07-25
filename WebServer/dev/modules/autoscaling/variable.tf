variable "launch_configuration_name" {}
variable "image_id" {}
variable "security_groups" {
    type = string
}
variable "instance_type" {}
variable "autoscaling_group_name" {}
variable "target_group_arn" {}
variable "policy_name" {}
variable "policy_type" {}
variable "predefined_metric_type" {}
variable "subnet_id" {
    type = string
}
