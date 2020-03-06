variable "elb_name" {}

variable "availability_zones" {
  default = []
}

variable "subnets" {
  default = []
}

variable "instance_port" {}

variable "lb_port" {}

variable "protocol" {}

variable "instances" {
  default = []
}

variable "tags" {
  default = {}
}

variable "security_group" {
  default = []
}
