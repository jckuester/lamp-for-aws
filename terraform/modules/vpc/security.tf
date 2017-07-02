resource "aws_security_group" "consul_gossip" {
  name = "consul agent -: consul agent"
  description = "Allow consul gossip between agents"
  vpc_id = "${aws_vpc.lamp.id}"

  ingress {
    from_port = 8301
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
}
