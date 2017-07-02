resource "aws_instance" "consul" {
  ami = "${data.aws_ami.consul.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.consul.*.id, count.index)}"
  private_ip = "${cidrhost(element(aws_subnet.consul.*.cidr_block, count.index), 4 + count.index)}"
  monitoring = true
  key_name = "${var.key_name}"

  count = "${var.consul_count}"

  vpc_security_group_ids = [
    "${aws_security_group.nodes_consul.id}",
    "${aws_security_group.consul_consul.id}",
    "${aws_security_group.bastion_consul.id}"
  ]

  tags {
    Name = "${var.consul_tag}"
  }
}

resource "aws_route53_zone" "lamp" {
  name = "lamp.int"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route53_record" "consul" {
  count = "${var.consul_count}"
  zone_id = "${aws_route53_zone.lamp.zone_id}"
  name = "consul${count.index}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.consul.*.private_ip, count.index)}"]
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
