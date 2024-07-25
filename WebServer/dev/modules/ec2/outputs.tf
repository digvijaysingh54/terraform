output "ec2_public_ip" {
  value = aws_instance.myinstance.*.public_ip
}
output "ec2_public_ip1" {
  value = aws_instance.myinstance.*.public_ip
}