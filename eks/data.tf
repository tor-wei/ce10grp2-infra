data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_user" "admin_users" {
  for_each  = toset(var.eks_admin_users)
  user_name = each.value
}

data "aws_iam_user" "developer_users" {
  for_each  = toset(var.eks_developer_users)
  user_name = each.value
}