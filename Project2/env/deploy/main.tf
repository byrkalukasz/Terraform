#Przygotowanie profidera
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "poweruser_stage"
  region = "eu-central-1"
}


module "eks" {
    source = "../../modules/eks-cluster"
}