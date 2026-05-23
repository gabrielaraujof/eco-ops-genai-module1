resource "aws_iam_policy" "developer_policy" {
  name        = "DeveloperAccessPolicy"
  description = "Policy for developer team"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "ec2:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = "iam:PassRole"
        Effect = "Allow"
        Resource = "*"
      }
    ]
  })
}

