data "aws_availability_zones" "availability_zones" {
  state = "available"
}

# Public subnets
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = format("${var.prefix}-public%02d", count.index + 1)
  })
}

# Private subnets
resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.tags, {
    Name = format("${var.prefix}-private%02d", count.index + 1)
  })
}

# Nat gateway EIP
resource "aws_eip" "nat_gateway_elastic_ips" {
  count = length(var.public_subnet_cidrs)
  vpc   = true

  tags = merge(local.tags, {
    Name = format("${var.prefix}-eip%02d", count.index + 1)
  })
}

# Nat gateway
resource "aws_nat_gateway" "nat_gateways" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat_gateway_elastic_ips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = merge(local.tags, {
    Name = format("${var.prefix}-ngw%02d", count.index + 1)
  })
}

# Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = merge(local.tags, {
    Name = "${var.prefix}-public"
  })
}

# Public route table association
resource "aws_route_table_association" "public_route_table_associations" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private route table
resource "aws_route_table" "private_route_tables" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
  }

  tags = merge(local.tags, {
    Name = format("${var.prefix}-private%02d", count.index + 1)
  })
}

# Private route table association
resource "aws_route_table_association" "private_route_table_associations" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_tables[count.index].id
}

# Default Security group
resource "aws_security_group" "default" {
  name        = "default-security-group-${var.prefix}"
  description = "Default security group for ${var.prefix}"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "default-security-group-${var.prefix}"
  })
}