resource "aws_security_group" "database" {
  name = "webserver -: database"
  description = "Allow connections from webservers"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${split(", ", "${var.webserver_cidrs}")}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.database_tag}"
  }
}

resource "aws_security_group" "database_database" {
  name = "database -: database"
  description = "Allow connections from other databases for replication"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.database.*.cidr_block}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.database_tag}"
  }
}

resource "aws_security_group" "bastion_database" {
  name = "bastion -: database"
  description = "Allow ssh from bastion"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.bastion_cidrs}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.database_tag}"
  }
}
