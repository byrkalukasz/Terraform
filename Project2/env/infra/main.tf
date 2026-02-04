module "eks" {
    source = "../../modules/eks-cluster"
    subnet_ids = [
      aws_subnet.eks_private_1a.id,
      aws_subnet.eks_private_1b.id
    ]
}