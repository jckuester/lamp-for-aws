resource "aws_subnet" "bastion" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 30)}"
  count = "${length(var.azs)}"
  availability_zone = "${format("%s%s", var.region, element(var.azs, count.index))}"

  tags {
    Name = "${var.bastion_tag}"
  }
}

resource "aws_route_table_association" "bastion" {
  count = "${length(var.azs)}"
  subnet_id = "${element(aws_subnet.bastion.*.id, count.index)}"
  route_table_id = "${var.route_table_id}"
}
