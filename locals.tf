locals {
  aws_region         = "ap-southeast-1"
  prefix             = "ce10grp2" # Set your desired prefix here
  s3_service_name    = "${local.prefix}-s3-service"
  s3_container_name  = "${local.s3_service_name}-container"
  sqs_service_name   = "${local.prefix}-sqs-service"
  sqs_container_name = "${local.sqs_service_name}-container"
}