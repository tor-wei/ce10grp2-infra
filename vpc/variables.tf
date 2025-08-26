variable "env" {
  description = "dev, uat or prod"
  type        = string
}
variable "region" {
  description = "The AWS region for this infra"
  type        = string
}
variable "name_prefix" {
  type = string
}