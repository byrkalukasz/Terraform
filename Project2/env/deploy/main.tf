terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  profile = "admin_gildia"
  region  = "eu-central-1"
}

locals {
  vpc_id = "vpc-0acbd8bfe05119cb6"
}

#Tworzenie NAT
#TODO: sprawdzić czy zadziala bez tego calego tworezenia NAT

data "aws_internet_gateway" "this" {
  filter {
    name   = "attachment.vpc-id"
    values = [local.vpc_id]
  }
}

resource "aws_subnet" "eks_public_1a" {
  vpc_id                  = local.vpc_id
  cidr_block              = "172.31.80.0/20"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                                = "eks-public-1a"
    "kubernetes.io/role/elb"            = "1"
    "kubernetes.io/cluster/eks-LB-test" = "shared"
  }
}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  tags = { Name = "rtb-eks-public" }
}

resource "aws_route" "public_default_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = data.aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.eks_public_1a.id
  route_table_id = aws_route_table.public.id
}


resource "aws_subnet" "eks_private_1a" {
  vpc_id            = local.vpc_id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "eu-central-1a"

  tags = {
    Name                                   = "eks-private-1a"
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/eks-LB-test"    = "shared"
  }
}

resource "aws_subnet" "eks_private_1b" {
  vpc_id            = local.vpc_id
  cidr_block        = "172.31.112.0/20"
  availability_zone = "eu-central-1b"

  tags = {
    Name                                   = "eks-private-1b"
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/eks-LB-test"    = "shared"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = { Name = "eip-nat-eks-lb-test" }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.eks_public_1a.id

  tags = { Name = "nat-eks-lb-test" }

  depends_on = [aws_route.public_default_igw]
}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id
  tags = { Name = "rtb-eks-private" }
}

resource "aws_route" "private_default_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "eks_private_1a" {
  subnet_id      = aws_subnet.eks_private_1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "eks_private_1b" {
  subnet_id      = aws_subnet.eks_private_1b.id
  route_table_id = aws_route_table.private.id
}

#Wywolanie modulu
module "eks" {
  source = "../../modules/eks-cluster"

  subnet_ids = [
    aws_subnet.eks_private_1a.id,
    aws_subnet.eks_private_1b.id
  ]
}
