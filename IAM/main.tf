provider "aws" {
  region = "ap-south-1" 
}

resource "aws_iam_user" "observability_user" {
  name = var.iam_user_name
  tags = {
    Purpose = "EKS Observability Stack"
  }
}

resource "aws_iam_policy" "observability_policy" {
  name        = var.policy_name
  description = "Least privilege policy for EKS Observability setup"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "EKSClusterManagement",
        Effect   = "Allow",
        Action   = [
          "eks:*",
          "ec2:Describe*",
          "ec2:CreateTags",
          "ec2:CreateSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateVpc*",
          "ec2:CreateSubnet",
          "ec2:CreateInternetGateway",
          "ec2:AttachInternetGateway",
          "iam:GetRole",
          "iam:PassRole",
          "elasticloadbalancing:*"
        ],
        Resource = "*"
      },
      {
        Sid    = "S3TerraformState",
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::my-observability-tfstate-bucket",
          "arn:aws:s3:::my-observability-tfstate-bucket/*"
        ]
      },
      {
        Sid    = "CloudWatchLogging",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.observability_user.name
  policy_arn = aws_iam_policy.observability_policy.arn
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.observability_user.name
}
