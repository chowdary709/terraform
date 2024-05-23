resource "aws_security_group" "sg" {
  name        = "${var.env}-${var.component}"
  description = "${var.env}-${var.component}"

  vpc_id = var.vpc_id
  // Define ingress rules
  ingress {
    description = "HTTP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
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
