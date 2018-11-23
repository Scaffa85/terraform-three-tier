terraform {
  backend "s3" {
    bucket         = "terraform-state-locking-cs"
    region         = "eu-west-2"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform_lock_table"
  }
}

provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "current" {}
