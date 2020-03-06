variable "ec2_name" {
  default = ""
}

variable "ec2_key" {}

variable "ec2_monitoring" {
  default = true
}

variable "tags" {
  default = {}
}

variable "ec2_associate_public_ip" {
  default = false
}

variable "ec2_ami" {}

variable "ec2_instance_type" {}

variable "ec2_subnet_id" {}

# variable "ec2_network_interface" {}

