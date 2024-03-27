resource "aws_lb" "metabase_load_balancer" {
  name               = "metabase-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_sg.id]
  subnets            = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
  depends_on         = [aws_internet_gateway.gw]
}

resource "aws_lb_target_group" "load_balancer_target_group" {
  name     = "load-balancer-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prod_vpc.id
}

resource "aws_lb_listener" "sh_front_end" {
  load_balancer_arn = aws_lb.metabase_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load_balancer_target_group.arn
  }
}