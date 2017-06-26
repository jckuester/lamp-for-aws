output "cidrs" {
  value = "${aws_subnet.bastion.cidr_block}"
}

output "key_name" {
  value = "${aws_key_pair.bastion.key_name}"
}

output "public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
