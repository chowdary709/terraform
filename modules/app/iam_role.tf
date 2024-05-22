resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action"    : "sts:AssumeRole",
        "Effect"    : "Allow",
        "Sid"       : ""
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "${var.env}-${var.component}"

    policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "VisualEditor0",
          "Effect": "Allow",
          "Action": [
            "ssm:GetParameters",
            "ssm:GetParametersByPath",
            "ssm:DescribeParameters"
          ],
          "Resource": "*"
        }
      ]
    })
  }

  tags = {
    tag-key = "${var.env}-${var.component}-role"
  }
}
# resource "aws_iam_instance_profile" "instance_profile" {
#   name = "${var.env}-${var.component}-role"
#   role = aws_iam_role.role.name
# }
