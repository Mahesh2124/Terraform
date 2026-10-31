resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc-${var.env}"
    Environment = "production"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each = var.public_subnets_config
  vpc_id = aws_vpc.main.id
  cidr_block = each.value["cidr"]
  availability_zone = each.value["availability_zone"]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  for_each = var.private_subnets_config
  vpc_id = aws_vpc.main.id
  cidr_block = each.value["cidr"]
  availability_zone = each.value["availability_zone"]
}

locals{
  unique_private_az = toset([for key, az in var.private_subnets_config: az.availability_zone])
  unique_public_az = toset([for key, az in var.public_subnets_config: az.availability_zone])
}

resource "aws_eip" "nat_eip" {
  for_each = local.unique_public_az
  domain = "vpc"
  tags = {
    Name = "nat-eip-${aws_subnet.public_subnet[each.key].id}"
    Environment = "Production"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each = local.unique_public_az
  subnet_id = aws_subnet.public_subnet[each.key].id
  allocation_id = aws_eip.nat_eip[each.key].id

  tags = {
    Name = "nat-${each.key}"
    Environment = "Production"
  }
  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.env}"
  }
}

resource "aws_route_table" "public" {
  for_each = local.unique_public_az
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
    Name = "public-route-table-${var.env}"
  }
}

# resource "aws_route" "public_route" {
#   route_table_id = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id = aws_internet_gateway.igw.id

# }

resource "aws_route_table_association" "public_subnet_route_associate" {
  for_each = local.unique_public_az
  subnet_id = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  for_each = aws_nat_gateway.nat
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }
    
  tags = {
    Name = "private-route-table-${var.env}"
  }
}

resource "aws_route_table_association" "private_subnet_route_associate" {
  for_each = local.unique_private_az
  subnet_id = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.private[each.value].id
}

