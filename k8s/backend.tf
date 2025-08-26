terraform {
  backend "s3" {
    bucket = "sctp-ce10-tfstate"
    key    = "ce10grp2/k8s.tfstate"
    region = "ap-southeast-1"
  }

  required_version = ">= 1.0.0"
}