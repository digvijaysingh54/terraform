output "ec2_public_ip" {
  value = aws_instance.myinstance.*.public_ip
}
