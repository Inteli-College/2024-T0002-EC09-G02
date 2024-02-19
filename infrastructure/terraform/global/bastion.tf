resource "aws_instance" "bastion_host" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"
  key_name      = "ec2_key_pair"

  subnet_id                   = aws_subnet.public_subnet_az1.id
  associate_public_ip_address = true

  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]

  tags = {
    Name = "Bastion_Host_Publica_ArqCorp"
  }
}