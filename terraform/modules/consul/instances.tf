resource "aws_instance" "consul" {
  ami = "${data.aws_ami.consul.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.consul.*.id, count.index)}"
  private_ip = "${cidrhost(element(aws_subnet.consul.*.cidr_block, count.index), 4 + count.index)}"
  monitoring = true
  key_name = "${var.key_name}"

  count = "${var.consul_count}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.nodes_consul.id}",
    "${aws_security_group.consul_consul.id}",
    "${aws_security_group.bastion_consul.id}"
  ]

  tags {
    Name = "${var.consul_tag}"
  }
}

data "aws_ami" "consul" {
  most_recent = true
  owners = ["${data.aws_caller_identity.current.account_id}"]

  filter {
    name = "name"
    values = ["consul-*"]
  }

  filter {
    name = "state"
    values = ["available"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "is-public"
    values = ["false"]
  }
}

data "aws_caller_identity" "current" {
  # no arguments
}
