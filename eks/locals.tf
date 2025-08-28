locals {
  admin_access_entries = {
    for user_name, user in data.aws_iam_user.admin_users : user_name => {
      principal_arn = user.arn
      policy_associations = {
        "cluster-admin-policy" = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  developer_access_entries = {
    for user_name, user in data.aws_iam_user.developer_users : user_name => {
      principal_arn = user.arn
      policy_associations = {
        "edit-namespaces-policy" = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"
          access_scope = {
            type       = "namespace"
            namespaces = var.eks_allowed_namespaces
          }
        }
        "view-cluster-policy" = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  all_access_entries = merge(
    local.admin_access_entries,
    local.developer_access_entries
  )
}