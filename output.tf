output "vpc_id" {
  value = module.vpc.vpc_id
}


output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_subnet_ids" {
  value = { for key, subnet in module.vpc.public_subnet_ids : key => {
    id                = subnet.id
    availability_zone = subnet.availability_zone
    }
  }
}

output "private_subnet_ids" {
  value = { for key, subnet in module.vpc.private_subnet_ids : key =>
    {
      id                = subnet.id
      availability_zone = subnet.availability_zone
    }
  }
}


output "alb_dns" {
  value = module.alb.alb_dns_name
}



output "db_port" {
  value = module.rds.db_port
}

output "db_name" {
  value = module.rds.db_name
}

output "rds_security_group_id" {
  value = module.rds.rds_security_group_id
}

output "db_identifier" {
  value = module.rds.db_identifier
}