resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "${var.env}-${var.component}-inline-policy"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "ssm:DescribeParameters",
            "ssm:GetParameterHistory",
            "ssm:GetParametersByPath",
            "ssm:GetParameters",
            "ssm:GetParameter"
          ],
          "Resource" : "*"
        }
      ]
    })
  }

  tags = {
    tag-key = "${var.env}-${var.component}-role"
  }
}

resource "aws_launch_template" "template" {
  name                   = "${var.env}-${var.component}"
  image_id               = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]

  iam_instance_profile {
    name = aws_iam_role.role.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    env = var.env
    role_name = var.component
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.env}-${var.component}"
    }
  }
}
