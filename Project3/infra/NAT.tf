//NAT do działania i przyłączenia EC2 pod EKSa
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "eip-nat-eks-lb-test" }
}

resource "aws_nat_gateway" "this" {
    for_each = aws_subnet.eks_public
    allocation_id = aws_eip.nat.id
    subnet_id = each.value.id
    
    tags = { Name = "nat-eks-lb-test" }
    depends_on = [aws_route.public_default_igw]
}

//PRywatny ruting
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.vpc.id
    tags = { Name = "rtb-eks-private" }
}

resource "aws_route" "private_default_nat" {
    for_each = aws_nat_gateway.this
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = each.value.id
}

resource "aws_route_table_association" "eks_private" {
    for_each = aws_subnet.private
    subnet_id = each.value.id
    route_table_id = aws_route_table.private.id
}

