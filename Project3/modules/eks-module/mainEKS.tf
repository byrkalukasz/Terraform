module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.name
  kubernetes_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  compute_config = {
    enabled = false
  }

  addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = var.nodepools
      
  tags = {
    Env         = "Stage"
    Terraform   = "true"
    Blame_Autor = "Łukasz Byrka"
  }
}