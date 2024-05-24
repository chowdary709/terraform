resource "aws_lb_target_group" "tg" {
  name     = "${var.env}-${var.component}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
#   health_check {
#     healthy_threshold   = 5
#     unhealthy_threshold = 1
#     timeout             = 5
#     Interval            = 5
#     path                = "./health"
#   }
}