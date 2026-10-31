
variable "env" {
  type = string
  description = "environment"
  default = "Prod"
}

variable "vpc_id" {
  type = string
  description = "vpc id value"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "list of public subnets"
}
