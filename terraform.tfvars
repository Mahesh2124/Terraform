vpc_name   = "practice"
cidr_block = "10.1.0.0/16"
region     = "us-east-1"
public_subnets_config = {
  "us-east-1a" = {
    "cidr"              = "10.1.1.0/24"
    "availability_zone" = "us-east-1a"
    "instance_count"    = 0
  }
    "us-east-1b" = {
    "cidr"              = "10.1.2.0/24"
    "availability_zone" = "us-east-1b"
    "instance_count"    = 0
  }
}
private_subnets_config = {
  "us-east-1b" = {
    "cidr"              = "10.1.3.0/24"
    "availability_zone" = "us-east-1b"
    "instance_count"    = 1
  }
    "us-east-1a" = {
    "cidr"              = "10.1.4.0/24"
    "availability_zone" = "us-east-1a"
    "instance_count"    = 1
  }
}
db_username = "dbadmin"