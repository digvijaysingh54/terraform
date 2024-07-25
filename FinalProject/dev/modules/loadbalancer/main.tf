# create security group for alb
resource "aws_security_group" "load_balancer_sg" {
  name_prefix = "load_balancer_sg_"
  vpc_id = var.lb_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
#create alb
resource "aws_lb" "alb" {
  name               = var.lb_name
  load_balancer_type = var.lb_type

  subnets            = [var.lb_subnet_id, var.lb_subnet_id_1]  
  security_groups    = [aws_security_group.load_balancer_sg.id]  

  tags = {
    Name = var.lb_tag
  }
}


# Create a target group
resource "aws_lb_target_group" "target_group" {
  name     = var.lb_tg_name
  port     = 80
  protocol = var.lb_protocol
  vpc_id   = var.lb_vpc_id

  health_check {
    interval            = 60
    timeout             = 30
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = var.lb_tg_tag
  }
}
# Create a listener to forward traffic from the ALB to the target group
resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = var.lb_protocol

  default_action {
    type             = var.lb_lst_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

