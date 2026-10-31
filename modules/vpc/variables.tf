variable "cidr" {
  type = string
  description = "cidr for the vpc"
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  description = "Name of the vpc"
  default = "practice"
}

variable "env" {
  type = string
  description = "Name of the vpc"
  default = "Prod"
}

variable "public_subnets_config" {
  type = map(object({
    cidr              = string
    availability_zone = string
    instance_count    = number 
  }))
  description = "Configuration map for multiple public subnets"
  default = {
   "us-east-1b" = {
      "cidr"              = "10.0.1.0/24"
      "availability_zone" = "us-east-1a"
      "instance_count" = 1
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
      "cidr"              = "10.0.1.0/24"
      "availability_zone" = "us-east-1b"
      "instance_count" = 1
    }
  }
}
