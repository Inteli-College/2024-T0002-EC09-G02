resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]

  tags = {
    Name = "DB_Subnet_Group_ArqCorp"
  }
}

resource "aws_db_instance" "main_postgresql_db" {
  identifier             = "prod-db"
  engine                 = "postgres"
  engine_version         = "15.3"
  username               = "postgres"
  db_name                = "stone"
  instance_class         = "db.t3.micro"
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  allocated_storage      = 20
  multi_az               = false
  password               = "postgres123"
  publicly_accessible    = true
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}
