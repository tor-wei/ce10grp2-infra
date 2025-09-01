variable "region" {
  description = "The AWS region for this infra"
  type        = string
}

variable "app_api_ecr_name" {
  description = "The name of the ECR use to store container image for app api"
  type        = string
}

variable "app_frontend_ecr_name" {
  description = "The name of the ECR use to store container image for app frontend"
  type        = string
}
