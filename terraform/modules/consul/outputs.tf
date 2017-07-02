output "consul0_private_ip" {
  value = "${aws_instance.consul.0.private_ip}"
}
