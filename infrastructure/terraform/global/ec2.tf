resource "aws_launch_template" "sh_ec2_launch_templ" {
  name_prefix   = "metabase-ec2-launch-template"
  image_id      = "ami-080e1f13689e07408"
  instance_type = "t3.medium"
  key_name      = "metabase_ec2_key"
  user_data = base64encode(<<-EOF
#!/bin/bash

sudo apt-get update -y
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# Cria e configura o docker-compose.yml
cat > docker-compose.yml <<-EOF_DOCKER
version: '3.8'
services:
  metabase:
    image: metabase/metabase:latest
    environment:
      MB_DB_TYPE: postgres
      MB_DB_DBNAME: postgres
      MB_DB_PORT: "5432"
      MB_DB_USER: postgres
      MB_DB_PASS: postgres123
      MB_DB_HOST: ${aws_db_instance.main_postgresql_db.address}
    ports:
      - "80:3000"
EOF_DOCKER

# Inicia o Metabase usando Docker Compose
docker compose up -d
EOF
  )

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