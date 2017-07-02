variable "lamp_tag" {
  default = "LAMP"
}

variable "webserver_tag" {
  default = "LAMP: Webserver"
}

variable "database_tag" {
  default = "LAMP: Database"
}

variable "bastion_tag" {
  default = "LAMP: Bastion"
}

variable "bastion_count" {
# set to either 0 or 1
default = 1
}

variable "consul_tag" {
  default = "LAMP: Consul"
}

variable "azs" {
  type = "list"
  default = ["a", "b"]
}

variable "consul_count" {
   # should be an odd number
   # to avoid data loss set at least to >= 3
   default = 1
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "PROFILE" { }

variable "REGION" { }
