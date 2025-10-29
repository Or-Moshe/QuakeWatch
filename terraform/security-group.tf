resource "aws_security_group" "quakewatch_sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.main.id

  # SSH
  ingress {
    description = "Allow SSH"
    from_port   = var.security_group_ingress_SSH_from_port
    to_port     = var.security_group_ingress_SSH_to_port
    protocol    = "tcp"
    cidr_blocks = var.security_group_allowed_ssh_cidr
  }

  # HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = var.security_group_ingress_HTTP_from_port
    to_port     = var.security_group_ingress_HTTP_to_port
    protocol    = "tcp"
    cidr_blocks = var.security_group_allowed_http_cidr
  }

  # HTTPS
  ingress {
    description = "Allow HTTPS"
    from_port   = var.security_group_ingress_HTTPS_from_port
    to_port     = var.security_group_ingress_HTTPS_to_port
    protocol    = "tcp"
    cidr_blocks = var.security_group_allowed_https_cidr
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
