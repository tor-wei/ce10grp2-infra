resource "aws_eks_pod_identity_association" "argocd_ecr_read" {
  cluster_name    = module.eks.cluster_name
  namespace       = "argocd"
  service_account = "argocd-server"
  role_arn        = aws_iam_role.ecr_read_role.arn
}

resource "aws_eks_pod_identity_association" "ebs_csi_association" {
  cluster_name    = module.eks.cluster_name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi_role.arn
}