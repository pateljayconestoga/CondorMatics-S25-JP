terraform {
  required_version = ">=1.10"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }

  backend "s3" {
    bucket = "condormatics-s25-tfstate-jp"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"
}