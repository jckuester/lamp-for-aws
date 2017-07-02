output "vpc_id" {
  value = "${aws_vpc.lamp.id}"
}

output "route_table_id" {
  value = "${aws_route_table.lamp.id}"
}

output "consul_gossip_security_group_id" {
  value = "${aws_security_group.consul_gossip.id}"
}
