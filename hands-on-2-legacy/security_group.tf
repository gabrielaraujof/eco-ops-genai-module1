resource "aws_security_group" "web_sg_legacy" {
  name        = "web-server-sg"
  description = "Security group for legacy web servers"
  vpc_id      = "vpc-12345678"

  ingress {
    description = "Allow SSH from anywhere (Temporary for debug)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
