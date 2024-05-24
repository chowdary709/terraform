resource "aws_lb_target_group" "tg" {
  name     = "${var.env}-${var.component}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    enabled             = true             # Enable health checks for the application
    healthy_threshold   = 2                # Number of consecutive successful health checks before considering the instance healthy
    unhealthy_threshold = 2                # Number of consecutive failed health checks before considering the instance unhealthy
    timeout             = 3                # Time (in seconds) to wait for a health check response before considering it a failure
    port                = var.app_port     # Port on which the health check requests will be sent (using a variable)
    interval            = 5                # Time (in seconds) between each health check
    path                = "./health"       # Path to the health check endpoint on the application
  }

}