output "ec2_public_ip" {
  value = aws_instance.digvijay.*.public_ip
}
