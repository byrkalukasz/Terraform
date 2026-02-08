//Subnety w 2 AZ
resource "aws_subnet" "eks_public" {
    for_each = local.public_subnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = true
    tags = {
        Name = "eks-public-${replace(each.key, local.region, "")}"
        "kubernetes.io/role/elb" = "1"
        "kubernetes.io/cluster/eks-LB-test" = "shared"
  }
}

resource "aws_subnet" "private" {
    for_each = local.private_subnets
    vpc_id = aws_vpc.vpc.id
    cidr_block = each.value
    availability_zone = each.key
    
    tags = {
        Name = "eks-private-${replace(each.key, local.region, "")}"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/eks-LB-test" = "shared"
        }
}