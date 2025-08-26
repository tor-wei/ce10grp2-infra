variable "region" {
  description = "The AWS region for this infra"
  type        = string
}
variable "cluster_name" {
  description = "The name of the eks cluster to apply the changes to"
  type        = string
}