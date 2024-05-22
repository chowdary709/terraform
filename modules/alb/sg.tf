resource "aws_security_group" "sg" {
  name        = "${var.env}-${var.lb_type}"
  description = "${var.env}-${var.lb_type}"

  vpc_id = var.vpc_id

  // Define ingress rules
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.alb_sg_allow_cidr]
  }

  // Define egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol = "-1"            // Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-${var.lb_type}-sg"
  }
}
