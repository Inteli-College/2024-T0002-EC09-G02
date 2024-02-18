resource "aws_instance" "bastion_host" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "tutorial-ec2"

  subnet_id                   = aws_subnet.public_subnet_az1.id
  associate_public_ip_address = true

  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]

  tags = {
    Name = "Bastion_Host_Publica_ArqCorp"
  }
}
