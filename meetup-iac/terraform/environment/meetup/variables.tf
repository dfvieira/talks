variable "region" {
  default = "us-east-2"
}

variable "cidr_vpc" {
  default = "192.168.8.0/23"
}

variable "subnet1" {
  default = "192.168.8.0/24"
}

variable "subnet2" {
  default = "192.168.9.0/24"
}

variable "ami" {
  default = "ami-00c03f7f7f2ec15c3"
}

variable "ec2_type" {
  default = "t2.micro"
}
