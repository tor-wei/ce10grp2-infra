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
variable "vpc_id" {
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
