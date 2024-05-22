resource "aws_security_group" "sg" {
  name        = "${var.env}-${var.component}"
  description = "${var.env}-${var.component}"

  vpc_id = var.vpc_id
  // Define ingress rules
  ingress {
    description = "HTTP"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks  // Allow SSH access from anywhere
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
  }
  // Define egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol = "-1"            // Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-${var.component}-sg"
  }
}
