terraform {
  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "ce10grp2.tfstate"
    region = "ap-southeast-1"
  }
}