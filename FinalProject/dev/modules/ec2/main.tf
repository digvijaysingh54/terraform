resource "aws_instance" "myinstance" {
  count            = var.instance_count
  ami              = var.ami
  instance_type    = var.instance_type
  subnet_id        = var.private_subnet_id_0
  #associate_public_ip_address = true
  security_groups = ["${var.security_group_id}"]
  user_data = <<-EOF
              #!/bin/bash
              sudo su -
              yum install httpd -y
              cd /
              wget https://raw.githubusercontent.com/GitHubDv123/Timestamp/main/index.html
              cp index.html var/www/html/
              systemctl enable httpd
              systemctl start httpd
              EOF
  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
      }
}
resource "aws_lb_target_group_attachment" "example_attachment" {
  count          = var.instance_count
  target_group_arn = var.lb_tg_arn
  target_id        = aws_instance.myinstance[count.index].id
  port             = 80
}

