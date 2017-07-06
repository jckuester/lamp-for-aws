data "template_file" "my_cnf" {
  template = "${file("${path.module}/my.cnf")}"
  count = "${var.database_count}"

  vars {
    server_id = "${count.index + 1}"
  }
}

data "template_file" "switch_master_slave" {
  template = "${file("${path.module}/switch_master_slave.sh.ctmpl")}"
}

data "template_cloudinit_config" "my_cnf" {
  gzip          = true
  base64_encode = false
  count = "${var.database_count}"

  part {
    content_type = "text/part-handler"
    content = "${file("${path.module}/../part-handler-text.py")}"
  }

  part {
    content_type = "text/plain-base64"
    filename = "/etc/mysql-lamp/my.cnf"
    content = "${base64encode("${element(data.template_file.my_cnf.*.rendered, count.index)}")}"
  }

  part {
    content_type = "text/plain-base64"
    filename = "/usr/local/bin/switch_master_slave.sh.ctmpl"
    content = "${base64encode("${data.template_file.switch_master_slave.rendered}")}"
  }
}

resource "aws_instance" "database" {
  ami = "${data.aws_ami.database.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.database.*.id, count.index)}"
  private_ip = "${cidrhost(element(aws_subnet.database.*.cidr_block, count.index), 4 + count.index)}"
  monitoring = true
  key_name = "${var.key_name}"
  user_data = "${element(data.template_cloudinit_config.my_cnf.*.rendered, count.index)}"

  count = "${var.database_count}"

  vpc_security_group_ids = [
    "${aws_security_group.database.id}",
    "${aws_security_group.database_database.id}",
    "${var.consul_gossip_security_group_id}",
    "${aws_security_group.bastion_database.id}"
  ]

  tags {
    Name = "${var.database_tag}"
  }
}

data "aws_ami" "database" {
  most_recent = true
  owners = ["${data.aws_caller_identity.current.account_id}"]

  filter {
    name = "name"
    values = ["mysql-*"]
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
