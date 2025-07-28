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