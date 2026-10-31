variable "env" {
  type = string
  default = "prod"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ec2_security_group_id" {
  description = "Only this security group can access RDS"
  type        = string
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "engine_version" {
  description = "Supported PostgreSQL engine version"
  type        = string
}

variable "multi_az" {
  type    = bool
  default = true
}

variable "db_username" {
  type = string
  sensitive = true
}