variable "vpc_id" { }
variable "vpc_cidr" { }
variable "region" { }
variable "azs" { type = "list"}
variable "bastion_count" { }
variable "bastion_tag" { }
variable "route_table_id" { }
