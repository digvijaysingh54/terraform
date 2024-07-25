resource "aws_launch_configuration" "example" {
  name                 = var.autoscaling_group_name
  image_id             = var.image_id  
  instance_type        = var.instance_type 
  security_groups      = [var.security_groups] 
  key_name             = "webkey"  
  user_data = <<-EOF
              #!/bin/bash
              sudo su -
              yum update -y
              yum install httpd -y
              cd /
              wget https://raw.githubusercontent.com/GitHubDv123/Timestamp/main/index.html
              cp index.html var/www/html/
              systemctl enable httpd
              systemctl start httpd
              EOF
}

resource "aws_autoscaling_group" "example" {
  name                 = var.autoscaling_group_name
  min_size             = 1
  max_size             = 4
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.example.name

  vpc_zone_identifier  = [var.subnet_id] 

  target_group_arns    = [var.target_group_arn]
}

resource "aws_autoscaling_policy" "example" {
  name                 = var.policy_name
  autoscaling_group_name = aws_autoscaling_group.example.name
  policy_type          = var.policy_type

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }
    target_value = 70.0  
  }
}
