
variable "env" {
  type = string
  description = "Env"
  default = "prod"
}


variable "instance_type" {
  type = string
  description = "type of the instace"
  default = "t3.micro"
}

variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "alb_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "min_size" {
  type = number
  description = "minimum no of instances to run"
}
variable "target_value" {
  type = number
  description = "value for scaling"
}

variable "max_size" {
  type = number
  description = "maximum no of instances to run"
}

variable "desired_capacity" {
  type = number
  description = "desired no of instances to run"
}
