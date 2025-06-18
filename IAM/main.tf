provider "aws" {
  region = "ap-south-1"
}

# IAM Group for Observability Stack
resource "aws_iam_group" "observability_group" {
  name = "EKSObservabilityGroup"
}

# IAM User
resource "aws_iam_user" "observability_user" {
  name           = var.iam_user_name
  force_destroy  = true  # helps during destroy if access keys exist
  tags = {
    Purpose = "EKS Observability Stack"
  }
}

# IAM Group Membership
resource "aws_iam_user_group_membership" "membership" {
  user   = aws_iam_user.observability_user.name
  groups = [aws_iam_group.observability_group.name]
}

# IAM Policy for Observability
resource "aws_iam_policy" "observability_policy" {
  name        = var.policy_name
  description = "Least privilege policy for EKS Observability setup"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "EKSClusterManagement",
        Effect = "Allow",
        Action = [
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
          "arn:aws:s3:::${var.tfstate_bucket_name}",
          "arn:aws:s3:::${var.tfstate_bucket_name}/*"
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

# Attach Policy to Group
resource "aws_iam_group_policy_attachment" "group_policy" {
  group      = aws_iam_group.observability_group.name
  policy_arn = aws_iam_policy.observability_policy.arn
}

# Create Access Key for the IAM User
resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.observability_user.name
}
