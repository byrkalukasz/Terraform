# module "s3" {
#     source = "../../modules/s3"
#     name = "app-${var.env}-lb"
#     tags = {
#       Name = "test-tf-pusty-LB"
#       Env = var.env
#     }
# }


module "eks_reczny" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

name = "eks-cluster-reczny-lb"
  kubernetes_version = "1.34"
  create_iam_role = false

  //Dopisane aby import działał
  iam_role_arn = "arn:aws:iam::441728895705:role/eks-LB-test-cluster-20260208101543859100000003"
  vpc_id = "vpc-091b3ed4fc729d5d7"

authentication_mode = "API"
  create_kms_key = false
    encryption_config = null
  create_node_security_group    = false
  endpoint_public_access       = true
  endpoint_private_access      = true
  endpoint_public_access_cidrs = ["0.0.0.0/0"]
    create_security_group      = false
  security_group_id     = null
  //to dopisal AI
  zonal_shift_config = {
  enabled = true
}

  enabled_log_types = ["api","audit","authenticator","controllerManager","scheduler"]

//Koniec dopisywania
  subnet_ids = [
    "subnet-0a0b47c51fcf8203d", 
    "subnet-0e23a787a00754b8d"
  ] 

  addons = {
coredns = { addon_version = "v1.12.3-eksbuild.1" }
  kube-proxy = { addon_version = "v1.34.0-eksbuild.2" }
  metrics-server = { addon_version = "v0.8.1-eksbuild.1" }
  aws-secrets-store-csi-driver-provider = { addon_version = "v2.1.1-eksbuild.1" }
  }

  //import nodepoola utworzonego recznie
    eks_managed_node_groups = {
    recznypool = {
      node_group_name = "recznypool"
      use_name_prefix = false
  create_launch_template      = false
  use_custom_launch_template  = false
  launch_template_id          = null
  launch_template_version     = null
      # IAM jest już ręcznie, więc nie twórz roli:
      create_iam_role = false
      iam_role_arn    = "arn:aws:iam::441728895705:role/linpool-eks-node-group-20260208101543859000000002"

      subnet_ids = [
        "subnet-0a0b47c51fcf8203d",
        "subnet-0e23a787a00754b8d"
      ]

      capacity_type  = "SPOT"
      instance_types = ["t3a.small"]
      ami_type       = "AL2023_x86_64_STANDARD"
      disk_size      = 20

        min_size     = 0
        max_size     = 3
        desired_size = 0

      update_config = {
  max_unavailable = 1
}
  tags = {
    Autor           = "Łukasz Byrka"
    importTerraform = "true"
  }

      labels = {}
    }
  }

}

//utworzono ręczny cluste eks-cluster-reczny-lb i dodano mu poola recznypool, uzyto VPC, subnetów i 
//aws_reszty stworzone podczas tworzenia poprzedniej czesci zadania

//NodePool
//aws eks describe-nodegroup \
//  --cluster-name eks-cluster-reczny-lb \
//  --nodegroup-name recznypool \
//  --region eu-central-1 \
//  --profile admin_prywatne \
//  --query 'nodegroup.{name:nodegroupName,nodeRole:nodeRole,subnets:subnets,scaling:scalingConfig,lt:launchTemplate,cap:capacityType,instanceTypes:instanceTypes,ami:amiType,labels:labels,taints:taints,disksize:diskSize,remote:remoteAccess,asg:resources.autoScalingGroups}'


//W przypadku kiedy zmieniamy konfiguracje terraform init -reconfigure -backend-config='../../config/state.config'
//Import
//1. Utworzony ręcznie S3 o nazwie app-pusty-lb
//2. Komenda terraform import module.s3.aws_s3_bucket.S3 app-pusty-lb
//aws eks describe-cluster   --name eks-cluster-reczny-lb   --region eu-central-1 --profile admin_prywatne   --query "clust
//er.{roleArn:roleArn,endpointPublic:endpointPublicAccess,endpointPrivate:endpointPrivateAccess,publicCidrs:publicAccessCidrs,version:version,encryption:encryptionConfig,logging:logging.cl
//usterLogging,resourcesVpcConfig:resourcesVpcConfig}" -> tym sprawdziłem 
//Ponizej import addonow
//terraform import 'module.eks_reczny.aws_cloudwatch_log_group.this[0]' '/aws/eks/eks-cluster-reczny-lb/cluster'

//terraform import 'module.eks_reczny.aws_eks_addon.this["coredns"]' 'eks-cluster-reczny-lb:coredns'
//terraform import 'module.eks_reczny.aws_eks_addon.this["kube-proxy"]' 'eks-cluster-reczny-lb:kube-proxy'
//terraform import 'module.eks_reczny.aws_eks_addon.this["metrics-server"]' 'eks-cluster-reczny-lb:metrics-server'
//terraform import 'module.eks_reczny.aws_eks_addon.this["aws-secrets-store-csi-driver-provider"]' 'eks-cluster-reczny-lb:aws-secrets-store-csi-driver-provider'

//Do importu ręczny EKS