terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.23.0"
    }
  }
  backend "s3" {
    bucket = "remote-s3-backend"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}