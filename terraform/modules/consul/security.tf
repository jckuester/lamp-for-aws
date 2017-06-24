resource "aws_security_group" "nodes_consul" {
  name = "nodes -: consul"
  description = "Allow inbound from all nodes"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 8300
    to_port = 8301
    protocol = "tcp"
    cidr_blocks = [
      "${var.vpc_cidr}"
    ]
  }
  ingress {
    from_port = 8301
    to_port = 8301
    protocol = "udp"
    cidr_blocks = [
      "${var.vpc_cidr}"
    ]
  }
  ingress {
    from_port = 8400
    to_port = 8400
    protocol = "tcp"
    cidr_blocks = [
      "${var.vpc_cidr}"
    ]
  }
  ingress {
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = [
      "${var.vpc_cidr}"
    ]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.consul_tag}"
  }
}

resource "aws_security_group" "consul_consul" {
  name = "consul -: consul"
  description = "Allow intra VPC traffic in consul"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [
      "${var.vpc_cidr}"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.consul_tag}"
  }
}
