terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # This ensures you use a compatible version
    }
  }
}

provider "aws" {
  region = var.region
}