resource "aws_iam_policy" "developer_policy" {
  name        = "DeveloperAccessPolicy"
  description = "Least-privilege policy for developer team"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowReadOnlyS3Access"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = [
          "arn:aws:s3:::company-dev-bucket",
          "arn:aws:s3:::company-dev-bucket/*"
        ]
      },
      {
        Sid    = "AllowDescribeEC2"
        Effect = "Allow"

        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
          "ec2:DescribeVolumes"
        ]

        Resource = "*"
      }
    ]
  })
}
