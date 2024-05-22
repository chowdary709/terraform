resource "aws_autoscaling_group" "asg" {
  name                = "${var.env}-${var.component}"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = var.subnets
  force_delete        = true

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}
