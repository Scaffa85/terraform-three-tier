resource "aws_instance" "hpae-head" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.hpae_head_instance_size, var.environment)}"
  count                  = "${var.hpae_head_instance_count}"
  subnet_id              = "${aws_subnet.SAS_HPAE.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "hpae-head-${count.index + 1}"
    Environment = "SAS HPAE"
  }
}

resource "aws_instance" "hpae-worker-tier" {
  ami                         = "${lookup(var.rhel_amis, var.region)}"
  instance_type               = "${lookup(var.hpae_worker_tier_instance_size, var.environment)}"
  count                       = "${var.hpae_worker_tier_instance_count}"
  associate_public_ip_address = false
  subnet_id                   = "${aws_subnet.SAS_HPAE.id}"
  vpc_security_group_ids      = ["${aws_security_group.base.id}"]
  key_name                    = "${var.deployer-key-name}"

  tags {
    Name        = "hpae-worker-${count.index + 1}"
    Environment = "SAS HPAE"
  }
}
