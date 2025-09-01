resource "aws_ecr_repository" "app_api" {
  name         = var.app_api_ecr_name
  force_delete = true
}

resource "aws_ecr_repository" "app_frontend" {
  name         = var.app_frontend_ecr_name
  force_delete = true
}