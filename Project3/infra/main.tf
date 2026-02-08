//Tworzenie EKS
module "eks" {
  source = "../modules/eks-module"
  vpc_id = aws_vpc.vpc.id
  name = local.cluster_name
  kubernetes_version = local.version
  nodepools = { 
    linpool = { 
      instance_types = ["t3a.small"] 
      capacity_type = "ON_DEMAND" 
      min_size = 2 
      max_size = 4 
      desired_size = 2 
      labels = { 
        pool = "Linpool" 
        os = "Linux" 
        } 
      } 
    linspot = {
      instance_types = ["t3a.small"] 
      capacity_type = "SPOT" 
      min_size = 0 
      max_size = 2 
      desired_size = 0 
      labels = { 
        pool = "Linspot" 
        os = "Linux" 
        } 
        } 
        }

  subnet_ids = [for s in aws_subnet.private : s.id] 
}
