variable "env" {
  description = "dev, uat or prod"
  type        = string
}
variable "region" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "eks_node_instance_type" {
  type = string
}
variable "eks_node_min_size" {
  type = number
}
variable "eks_node_max_size" {
  type = number
}
variable "eks_node_desired_size" {
  type = number
}
variable "eks_admin_users" {
  description = "A list of existing IAM user names to grant cluster-admin access."
  type        = list(string)
  default     = []
}
variable "eks_developer_users" {
  description = "A list of existing IAM user names to grant developer access."
  type        = list(string)
  default     = []
}
variable "eks_allowed_namespaces" {
  description = "A list of namespaces to grant developers access to."
  type        = list(string)
  default     = []
}
variable "app_api_ecr_name" {
  description = "The name of the ECR use to store container image for app api"
  type        = string
}

variable "app_frontend_ecr_name" {
  description = "The name of the ECR use to store container image for app frontend"
  type        = string
}
