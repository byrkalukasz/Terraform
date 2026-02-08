//Tworzenie EKS
module "eks" {
  source = "../../modules/eks-cluster"
  vpc_id = aws_vpc.vpc.id
  name = local.cluster_name
  kubernetes_version = local.version

  subnet_ids = [for s in aws_subnet.private : s.id] 
}
