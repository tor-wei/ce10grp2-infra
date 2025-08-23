variable "env" {
  description = "dev, uat or prod"
  type        = string
}
variable "region" {
  description = "The AWS region for this infra"
  type        = string
}
variable "eks_node_instance_type" {
  description = "Instance type of the EC2 running as node"
  type        = string
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