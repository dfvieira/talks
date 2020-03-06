output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "rtb_id" {
  value = "${aws_vpc.this.default_route_table_id}"
}

output "sg_id" {
  value = "${aws_vpc.this.default_security_group_id}"
}
