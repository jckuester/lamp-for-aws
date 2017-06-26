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

variable "azs" {
  type = "list"
  default = ["a", "b"]
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "PROFILE" { }

variable "REGION" { }
