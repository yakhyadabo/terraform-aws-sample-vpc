# DMZ Subnet
resource "aws_subnet" "dmz_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.dmz_subnets_cidr)
  cidr_block              = element(var.dmz_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-dmz-subnet"
    Tier = local.tier.dmz
  }
}

# Routing tables to route traffic for DMZ Subnet
resource "aws_route_table" "dmz" {
  count          = length(var.dmz_subnets_cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.environment}-dmz-route-table"
  }
}

# Route for NAT
resource "aws_route" "dmz_nat_gateway" {
  count          = length(var.dmz_subnets_cidr) > 0 ? 1 : 0
  route_table_id         = aws_route_table.dmz[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Route table associations for DMZ Subnets
resource "aws_route_table_association" "dmz" {
  count          = length(var.dmz_subnets_cidr)
  subnet_id      = element(aws_subnet.dmz_subnet.*.id, count.index)
  route_table_id = aws_route_table.dmz[0].id
}