module "namespaces"{
  source = "../modules/namespace"
}

//Tworzenie EKS
module "eks" {
  source = "../modules/eks-module"
  vpc_id = aws_vpc.vpc.id
  name = local.cluster_name
  kubernetes_version = local.version
  nodepools = var.pools

  subnet_ids = [for s in aws_subnet.private : s.id] 
}
