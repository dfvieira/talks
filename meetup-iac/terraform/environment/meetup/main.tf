provider "aws" {
  region = "${var.region}"
}

module "vpc-demo" {
  source   = "../../modules/vpc"
  vpc_cidr = "${var.cidr_vpc}"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "vpc-demo-${var.region}")
  )}"
}

module "igw-demo" {
  source = "../../modules/igw"
  vpc_id = "${module.vpc-demo.vpc_id}"

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "igw-demo-${var.region}")
  )}"
}

module "subnet-demo1" {
  source       = "../../modules/subnet"
  vpc_id       = "${module.vpc-demo.vpc_id}"
  block_subnet = ["${var.subnet1}"]
  azs          = ["us-east-2a"]

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "subnet-demo-us-east-2a")
  )}"
}

module "subnet-demo2" {
  source       = "../../modules/subnet"
  vpc_id       = "${module.vpc-demo.vpc_id}"
  block_subnet = ["${var.subnet2}"]
  azs          = ["us-east-2b"]

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "subnet-demo-us-east-2b")
  )}"
}

module "igw-route" {
  source                 = "../../modules/route"
  route_table_id         = "${module.vpc-demo.rtb_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${module.igw-demo.igw_id}"
}

module "rtb-attach-sunet1" {
  source         = "../../modules/rtb_attach"
  route_table_id = "${module.vpc-demo.rtb_id}"
  subnet_id      = "${module.subnet-demo1.id_sub[0]}"
}

module "rtb-attach-sunet2" {
  source         = "../../modules/rtb_attach"
  route_table_id = "${module.vpc-demo.rtb_id}"
  subnet_id      = "${module.subnet-demo2.id_sub[0]}"
}

module "sg-allow-80" {
  source      = "../../modules/sg_rule"
  type        = "ingress"
  from_port   = "80"
  to_port     = "80"
  protocol    = "tcp"
  cidr_blocks = "0.0.0.0/0"

  security_group_id = "${module.vpc-demo.sg_id}"
}

module "sg-allow-22" {
  source      = "../../modules/sg_rule"
  type        = "ingress"
  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = "0.0.0.0/0"

  security_group_id = "${module.vpc-demo.sg_id}"
}

module "ec2-demo-1" {
  source                  = "../../modules/ec2"
  ec2_ami                 = "${var.ami}"
  ec2_instance_type       = "${var.ec2_type}"
  ec2_key                 = "ec2-key"
  ec2_monitoring          = true
  ec2_subnet_id           = "${module.subnet-demo1.id_sub[0]}"
  ec2_associate_public_ip = true

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ec2-demo-web1")
  )}"
}

module "ec2-demo-2" {
  source                  = "../../modules/ec2"
  ec2_ami                 = "${var.ami}"
  ec2_instance_type       = "${var.ec2_type}"
  ec2_key                 = "ec2-key"
  ec2_monitoring          = true
  ec2_subnet_id           = "${module.subnet-demo2.id_sub[0]}"
  ec2_associate_public_ip = true

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "ec2-demo-web2")
  )}"
}

module "elb-web" {
  source         = "../../modules/elb"
  elb_name       = "elb-web"
  security_group = ["${module.vpc-demo.sg_id}"]
  instance_port  = 80
  protocol       = "http"
  lb_port        = 80
  instances      = ["${module.ec2-demo-1.id}", "${module.ec2-demo-2.id}"]
  subnets        = ["${module.subnet-demo1.id_sub[0]}", "${module.subnet-demo2.id_sub[0]}"]

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "elb-web")
  )}"
}
