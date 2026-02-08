//IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = { Name = "rtb-eks-public" }
}

resource "aws_route" "public_default_igw" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_1a" {
  for_each = aws_subnet.eks_public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public.id
}
