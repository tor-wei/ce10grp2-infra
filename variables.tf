locals {
  prefix             = "ce10grp2" # Set your desired prefix here
  s3_container_name  = "ce10grp2-s3-service-container"
  sqs_container_name = "ce10grp2-sqs-service-container"
}

variable "vpc_name" {
  description = "The ID of the VPC"
  type        = string
  default     = "ce10grp2-vpc-tf-module"
}

variable "created_by" {
    description = "The name of vpc creator"
    type        = string
    default     = "ce10grp2"
}