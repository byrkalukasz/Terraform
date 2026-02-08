terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  //profile = "admin_gildia"
  profile = "admin_prywatne"
  region  = "eu-central-1"
}