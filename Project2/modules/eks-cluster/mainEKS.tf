module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    name = "eks-LB-test"
    kubernetes_version = "1.33"
    
    create_iam_role = false
    iam_role_arn = "arn:aws:iam::221082192465:role/stage-01-eks-cluster-20250210083129583200000003"

    compute_config = {
        enable = false
    }

    vpc_id = "vpc-07505c96ebab59e64"
    subnet_ids = [
        "subnet-0a0d8b0a348cfa7a5",  # stage-01-vpc-private-eu-central-1a
        "subnet-0511f9a6627a745cd",  # stage-01-vpc-private-eu-central-1b
        "subnet-052eb545d6eb696de"   # stage-01-vpc-private-eu-central-1c
    ]
eks_managed_node_groups = {
        linpool = {
        instance_types = ["t3a.small"]
        capacity_time = "ON_DEMAND"
        min_size = 1
        desired_size = 1
        max_size = 1
        labels = {
            pool = "Linpool"
            os = "linux"
        }
    }
        nodespot = {
        instance_types = ["t3a.small"]
        capacity_time = "SPOT"
        min_size = 1
        desired_size = 1
        max_size = 1
        labels = {
            pool = "nodespot"
            os = "linux"
        }
    }
        winpool = {
        instance_types = ["t3.large"]
        capacity_time = "ON_DEMAND"
        min_size = 0
        desired_size = 0
        max_size = 1
        labels = {
            pool = "winpool"
            os = "Windows"
        }
    }
}

    tags = {
        Env = "Stage"
        Terraform = "true"
        Blame_Autor = "Łukasz Byrka"
    }
}