resource "aws_security_group" "bastion" {
  name = "you -: bastion"
  description = "Allow external inbound ssh"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    # restrict IPs to the ones you login from
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.bastion_tag}"
  }
}
