provider "aws" {
  version = ">= 0.1.4"

  region = "${var.REGION}"
  # default location is $HOME/.aws/credentials
  profile = "${var.PROFILE}"
}

terraform {
  required_version = ">= 0.10.0"
}

module "vpc" {
  source = "modules/vpc"

  vpc_cidr = "${var.vpc_cidr_block}"
  lamp_tag = "${var.lamp_tag}"
}

module "webserver" {
  source = "modules/webserver"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_cidr = "${var.vpc_cidr_block}"
  azs = "${var.azs}"
  region = "${var.REGION}"
  webserver_tag = "${var.webserver_tag}"

  # other module dependencies
  db_server_address = "${module.database.server_address}"
  route_table_id = "${module.vpc.route_table_id}"
  bastion_cidrs = "${module.bastion.cidrs}"
  key_name = "${module.bastion.key_name}"
}

module "database" {
  source = "modules/database"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_cidr = "${var.vpc_cidr_block}"
  azs = "${var.azs}"
  region = "${var.REGION}"
  database_tag = "${var.database_tag}"

  # other module dependencies
  webserver_cidrs = "${module.webserver.webserver_cidrs}"
}

module "bastion" {
  source = "modules/bastion"

  vpc_id = "${module.vpc.vpc_id}"
  vpc_cidr = "${var.vpc_cidr_block}"
  azs = "${var.azs}"
  region = "${var.REGION}"
  bastion_count = "${var.bastion_count}"
  bastion_tag = "${var.bastion_tag}"

  # other module dependencies
  route_table_id = "${module.vpc.route_table_id}"
}
