output "elb_dns_name" {
  value = "${module.webserver.elb_dns_name}"
}

output "bastion_public_ip" {
  value = "${module.bastion.public_ip}"
}
