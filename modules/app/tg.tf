resource "aws_lb_target_group" "tg" {
  name     = "${var.env}-${var.component}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 5
    unhealthy_threshold = 2
    port                = var.app_port
    path                = "/health"
    timeout             = 3
  }
}