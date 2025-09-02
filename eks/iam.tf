data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

data "aws_iam_policy_document" "ecr_read_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = [
      "arn:aws:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/${var.app_api_ecr_name}",
      "arn:aws:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/${var.app_frontend_ecr_name}"
    ]
  }
}

data "aws_iam_policy_document" "external_dns_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResources"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "ecr_read_role" {
  name               = "${var.name_prefix}-${var.env}-ecr-read-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "ecr_read_policy" {
  name   = "${var.name_prefix}-${var.env}-ecr-read-policy"
  policy = data.aws_iam_policy_document.ecr_read_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ecr_read_policy_attachment" {
  role       = aws_iam_role.ecr_read_role.name
  policy_arn = aws_iam_policy.ecr_read_policy.arn
}

resource "aws_iam_role" "ebs_csi_role" {
  name               = "${var.name_prefix}-${var.env}-ebs-csi-driver-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy_attachment" {
  role       = aws_iam_role.ebs_csi_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role" "external_dns_role" {
  name               = "${var.name_prefix}-${var.env}-external-dns-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "external_dns_policy" {
  name   = "${var.name_prefix}-${var.env}-external_dns-policy"
  policy = data.aws_iam_policy_document.external_dns_policy_document.json
}

resource "aws_iam_role_policy_attachment" "external_dns_policy_attachment" {
  role       = aws_iam_role.external_dns_role.name
  policy_arn = aws_iam_policy.external_dns_policy.arn
}
