locals {
    project = "lb-test"
    region = "eu-central-1"
    cluster_name = "eks-LB-test"
    version = "1.34"
    
    vpc_cidr = "10.0.0.0/16"
    public_subnets = {
        "eu-central-1a" = "10.0.0.0/20"
        }

    private_subnets = {
    "eu-central-1a" = "10.0.16.0/20"
    "eu-central-1b" = "10.0.32.0/20"
  }

  tags = {
    Project = local.project
    Env = var.env
  }
}