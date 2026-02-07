variable "subnet_ids" {
  type = list(string)
}

# LT dla windowsa, na sztywno wybrany windows 2022 core
# Zakomentowane podobnie jak poniżej
# resource "aws_launch_template" "winpool" {
#   name_prefix   = "lt-winpool-"
#   image_id      = "ami-0f90f52ddde3cfff7"
#   instance_type = "t3.large"

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "winpool"
#     }
#   }
# }


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "eks-LB-test"
  kubernetes_version = "1.34"

  vpc_id     = "vpc-0acbd8bfe05119cb6"
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

  eks_managed_node_groups = {
    linpool = {
      instance_types = ["t3a.small"]
      capacity_type  = "ON_DEMAND"
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      labels = {
        pool = "Linpool"
        os   = "linux"
      }
    }
        linspot = {
      instance_types = ["t3a.small"]
      capacity_type  = "SPOT"
      min_size       = 0
      max_size       = 2
      desired_size   = 0

      labels = {
        pool = "Winpool"
        os   = "windows"
      }
    }
    winpool = {
        #Zakomentowanie aby nie generować dodwatkowych ksoztów, z tego co się dowiedziałem potrzeba jeszce lunch tempate
        #Zrobiony powyzej
        #platform = "windows"
      instance_types = ["t3a.small"]
      capacity_type  = "ON_DEMAND"
      min_size       = 0
      max_size       = 2
      desired_size   = 0

    #   launch_template = {
    #     id = aws_launch_template.winpool.id
    #     version = "$Latests"
    #   }

      labels = {
        pool = "Winpool"
        os   = "windows"
      }
    }
  }

  tags = {
    Env         = "Stage"
    Terraform   = "true"
    Blame_Autor = "Łukasz Byrka"
  }
}