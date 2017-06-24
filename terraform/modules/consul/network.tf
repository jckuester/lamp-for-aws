resource "aws_subnet" "consul" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 20)}"
  count = "${length(var.azs)}"
  availability_zone = "${format("%s%s", var.region, element(var.azs, count.index))}"

  tags {
    Name = "${var.consul_tag}"
  }
}
