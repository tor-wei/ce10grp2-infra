resource "aws_ecr_repository" "s3_service" {
  name         = "${local.s3_service_name}-ecr"
  force_delete = true
}

resource "aws_ecr_repository" "sqs_service" {
  name         = "${local.sqs_service_name}-ecr"
  force_delete = true
}