


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

module "vpc" {
  source                 = "./modules/vpc"
  vpc_name               = var.vpc_name
  cidr                   = var.cidr_block
  public_subnets_config  = var.public_subnets_config
  private_subnets_config = var.private_subnets_config

}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [for subnet in module.vpc.public_subnet_ids : subnet.id]
}

module "asg" {
  source                = "./modules/asg"
  instance_type         = var.ec2_instance_type
  ami_id                = data.aws_ami.ubuntu.id
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = [for subnet in module.vpc.private_subnet_ids : subnet.id]
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  target_group_arn      = module.alb.target_group_arn
  target_value          = var.target_value
  alb_security_group_id = module.alb.alb_security_group_id

}

module "rds" {
  source = "./modules/rds"
  private_subnet_ids = [for subnet in module.vpc.private_subnet_ids : subnet.id]
  engine_version = "14"
  vpc_id = module.vpc.vpc_id
  ec2_security_group_id = module.asg.ec2_security_group_id
  allocated_storage = var.allocated_storage
  db_instance_class = var.db_instance_class
  db_username = var.db_username
}

# module "ec2" {
#   source = "./modules/ec2"
#   for_each = var.public_subnets_config
#   subnet_id = module.vpc.public_subnet_ids[each.key].id
#   ec2_instance_type = var.ec2_instance_type
#   instance_count = each.value.instance_count
#   vpc_id = module.vpc.vpc_id
# }


