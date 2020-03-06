variable "vpc_id" {}

variable "block_subnet" {
  default = ["10.0.1.0/24"]
}

variable "subnet_name" {
  default = ""
}

variable "tags" {
  default = {}
}

variable "azs" {
  default = []
}
