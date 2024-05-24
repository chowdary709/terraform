resource "aws_lb" "lb" {
  name               = "${var.env}-${var.lb_type}"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = var.subnets

  tags = {
    Environment = "${var.env}-${var.lb_type}"
  }
}
