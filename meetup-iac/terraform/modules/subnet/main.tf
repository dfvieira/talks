resource "aws_subnet" "this" {
  count             = "${length(var.azs)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(var.block_subnet, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"

  tags = "${merge(map("Name", format("%s-%s", var.subnet_name, element(var.azs, count.index))), var.tags)}"
}
