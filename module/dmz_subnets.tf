## Internet Gateway for Public Subnet
#resource "aws_internet_gateway" "ig" {
#  vpc_id = aws_vpc.vpc.id
#  tags = {
#    Name        = "${var.environment}-igw"
#  }
#}
#
## Public subnet
#resource "aws_subnet" "dmz_subnet" {
#  vpc_id                  = aws_vpc.vpc.id
#  count                   = length(var.dmz_subnets_cidr)
#  cidr_block              = element(var.dmz_subnets_cidr, count.index)
#  availability_zone       = element(var.availability_zones, count.index)
#  map_public_ip_on_launch = true
#
#  tags = {
#    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
#    Zone = "public"
#  }
#}
#
## Routing tables to route traffic for Public Subnet
#resource "aws_route_table" "dmz" {
#  vpc_id = aws_vpc.vpc.id
#
#  tags = {
#    Name        = "${var.environment}-public-route-table"
#  }
#}
#
## Route for Internet Gateway
#resource "aws_route" "dmz_internet_gateway" {
#  route_table_id         = aws_route_table.dmz.id
#  destination_cidr_block = "0.0.0.0/0"
#  gateway_id             = aws_internet_gateway.ig.id
#}
#
## Route table associations for both Public Subnets
#resource "aws_route_table_association" "dmz" {
#  count          = length(var.dmz_subnets_cidr)
#  subnet_id      = element(aws_subnet.dmz_subnet.*.id, count.index)
#  route_table_id = aws_route_table.public.id
#}
