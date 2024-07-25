output "lb_tg_arn_outputs" {
    value = aws_lb_target_group.target_group.arn 
}
output "lb_security_group_id_outputs" {
    value = aws_security_group.load_balancer_sg.id
  
}