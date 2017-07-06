variable "vpc_id" {}
variable "vpc_cidr" {}
variable "region" {}
variable "azs" { type = "list" }
variable "webserver_cidrs" {}
variable "database_tag" {}
variable "database_count" {}
variable "consul_gossip_security_group_id" {}
variable "key_name" {}
variable "bastion_cidrs" { type = "list" }
