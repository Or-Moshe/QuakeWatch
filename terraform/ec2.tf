resource "aws_instance" "quakewatch-server" {
  ami           = "ami-08982f1c5bf93d976"
  instance_type = var.instance_type

  subnet_id              = aws_subnet.public.id         # ✅ place instance inside your VPC
  vpc_security_group_ids = [aws_security_group.quakewatch_sg.id]
  associate_public_ip_address = true                    # ✅ ensure instance can reach internet
  user_data = file("./bootstrap.sh")

  tags = {
    Name = var.instance_tag
  }
}