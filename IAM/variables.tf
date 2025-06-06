variable "iam_user_name" {
  description = "IAM user name for EKS provisioning"
  default = "eks-observability-user"  
}
variable "policy_name" {
  description = "custom policy name"
  default = "EKSObservabilityPolicy"
  
}