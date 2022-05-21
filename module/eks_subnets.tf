# EKS cluster Subnets
resource "aws_subnet" "eks_cluster_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.eks_cluster_subnets_cidr)
  cidr_block              = element(var.eks_cluster_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-eks-cluster-private-subnet"
    Zone = local.zone.eks_cluster
  }
}

# Routing tables to route traffic for EKS cluster Subnets
resource "aws_route_table" "eks_cluster" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-eks-cluster-route-table"
  }
}

# Route for NAT
resource "aws_route" "eks_cluster_nat_gateway" {
  route_table_id         = aws_route_table.eks_cluster.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Route table associations for EKS cluster Subnets
resource "aws_route_table_association" "eks_cluster" {
  count          = length(var.eks_cluster_subnets_cidr)
  subnet_id      = element(aws_subnet.eks_cluster_subnet.*.id, count.index)
  route_table_id = aws_route_table.eks_cluster.id
}