terraform {
  backend "s3" {
    bucket = "sctp-ce10-tfstate"
    key    = "${local.prefix}.tfstate"
    region = "ap-southeast-1"
  }
}