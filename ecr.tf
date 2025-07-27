resource "aws_ecr_repository" "s3_service" {
  name         = "${local.prefix}-s3-service-ecr"
  force_delete = true
}

resource "aws_ecr_repository" "service3" {
  name         = "${local.prefix}-sqs-service-ecr"
  force_delete = true
}