variable "cidr_block" {
  type        = string
  description = "cidr for the vpc"
  default     = "10.1.0.0/16"
}

variable "region" {
  type        = string
  description = "Name of the region"
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the vpc"
  default     = "practice"
}

variable "env" {
  type        = string
  description = "Name of the vpc"
  default     = "Prod"
}

variable "public_subnets_config" {
  type = map(object({
    cidr              = string
    availability_zone = string
    instance_count    = number
  }))
  description = "Configuration map for multiple public subnets"
  default = {
    "us-east-1a" = {
      "cidr"              = "10.1.1.0/24"
      "availability_zone" = "us-east-1a"
      "instance_count"    = 1
    }
  }
}

variable "private_subnets_config" {
  type = map(object({
    cidr              = string
    availability_zone = string
    instance_count    = number
  }))
  description = "Configuration map for multiple private subnets"
  default = {
    "us-east-1b" = {
      "cidr"              = "10.1.2.0/24"
      "availability_zone" = "us-east-1b"
      "instance_count"    = 1
    }
  }
}

#asg variables
variable "ec2_instance_type" {
  type        = string
  description = "type of ec2 instance to create"
  default     = "t3.micro"
}


variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}
variable "desired_capacity" {
  type    = number
  default = 1
}
variable "target_value" {
  type    = number
  default = 70
}


#rds variables
variable "db_username" {
  type = string
  sensitive = true
}
variable "db_instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "multi_az" {
  type    = bool
  default = true
}
