resource "aws_subnet" "webserver" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 1)}"
  count = "${length(var.azs)}"
  availability_zone = "${format("%s%s", var.region, element(var.azs, count.index))}"

  tags {
    Name = "${var.webserver_tag}"
  }
}

resource "aws_route_table_association" "webserver" {
  count = "${length(var.azs)}"
  subnet_id = "${element(aws_subnet.webserver.*.id, count.index)}"
  route_table_id = "${var.route_table_id}"
}
