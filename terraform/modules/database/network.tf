resource "aws_subnet" "database" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 10)}"
  count = "${length(var.azs)}"
  availability_zone = "${format("%s%s", var.region, element(var.azs, count.index))}"

  tags {
    Name = "${var.database_tag}"
  }
}
