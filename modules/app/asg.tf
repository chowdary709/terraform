resource "aws_autoscaling_group" "asg" {
  name                = "${var.env}-${var.component}"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
  force_delete        = true

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}
