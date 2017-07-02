resource "aws_instance" "bastion" {
  ami = "${data.aws_ami.bastion.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.bastion.*.id, count.index)}"
  private_ip = "${cidrhost(element(aws_subnet.bastion.*.cidr_block, count.index), 4 + count.index)}"
  key_name = "${aws_key_pair.bastion.key_name}"
  monitoring = true

  count = "${var.bastion_count}"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.bastion.id}",
    "${var.consul_gossip_security_group_id}"
  ]

  tags {
    Name = "${var.bastion_tag}"
  }
}

data "aws_ami" "bastion" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["*ubuntu-trusty-14.04-amd64-server-*"]
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
    values = ["true"]
  }
}
