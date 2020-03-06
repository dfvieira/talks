output "vpc_id" {
  value = "${module.vpc-demo.vpc_id}"
}

output "rtb_id" {
  value = "${module.vpc-demo.rtb_id}"
}

output "sg_id" {
  value = "${module.vpc-demo.sg_id}"
}

output "ip_web1" {
  value = "${module.ec2-demo-1.public_ip}"
}

output "ip_web2" {
  value = "${module.ec2-demo-2.public_ip}"
}

output "elb_dns" {
  value = "${module.elb-web.dns_name}"
}
