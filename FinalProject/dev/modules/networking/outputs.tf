output "vpc_id_outputs" {
    value = aws_vpc.vpc.id
}
output "subnet_id_outputs" {
    value = element(aws_subnet.public_subnet.*.id, 0)
}
output "subnet_id_outputs1" {
    value = element(aws_subnet.public_subnet.*.id, 1)
}
output "security_gp_outputs" {
    value = aws_security_group.security_gp.id
}
output "private_subnet_id_outputs_0" {
    value = element(aws_subnet.private_subnet.*.id, 0)  
}
output "private_subnet_id_outputs_1" {
    value = element(aws_subnet.private_subnet.*.id, 1)  
}