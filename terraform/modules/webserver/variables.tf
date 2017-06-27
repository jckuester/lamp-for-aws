variable "vpc_id" { }
variable "vpc_cidr" { }
variable "region" { }
variable "azs" { type = "list"}
variable "webserver_tag" { }

# dependencies from other modules
variable "db_server_address" { }
variable "route_table_id" { }
variable "bastion_cidrs" { type = "list" }
variable "key_name" { }
