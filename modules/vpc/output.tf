output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
    value = { for key, subnet in aws_subnet.public_subnet : key => {
        id = subnet.id 
        availability_zone = subnet.availability_zone
            }
        }
}

output "private_subnet_ids" {
    value = { for key, subnet in aws_subnet.private_subnet : key => 
        {
            id = subnet.id 
            availability_zone = subnet.availability_zone
        }
    }
}

output "internet_gateway_id" {
    value = aws_internet_gateway.igw.id
}
