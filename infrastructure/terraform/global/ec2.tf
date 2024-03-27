resource "aws_launch_template" "sh_ec2_launch_templ" {
  name_prefix   = "metabase-ec2-launch-template"
  image_id      = "ami-080e1f13689e07408"
  instance_type = "t3.medium"
  key_name      = "metabase_ec2_key"
  user_data     = filebase64("metabase-template.sh")

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public_subnet_az1.id
    security_groups             = [aws_security_group.private_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "metabase-ec2-instance" 
    }
  }
}

resource "aws_autoscaling_group" "metabase_asg" {
  desired_capacity = 1
  max_size         = 6
  min_size         = 1

  target_group_arns = [aws_lb_target_group.load_balancer_target_group.arn]

  vpc_zone_identifier = [
    aws_subnet.public_subnet_az1.id
  ]

  launch_template {
    id      = aws_launch_template.sh_ec2_launch_templ.id
    version = "$Latest"
  }
}