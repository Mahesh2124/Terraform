variable "ec2_instance_type" {
  type = string
  description = "type of ec2 instance to create"
  default = "t3.micro"
}
variable "subnet_id" {
  type = string
  description = "Enter the the subnet id"
}

variable "env" {
  type = string
  description = "Name of the ec2"
  default = "Prod"
}

variable "instance_count" {
  type = number
  description = "Count of instances"
  default = 1
}

variable "vpc_id" {
  type = string
  description = "vpc id"
}