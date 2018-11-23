resource "aws_instance" "metadata-tier" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.metadata_tier_instance_size, var.environment)}"
  count                  = "${var.metadata_tier_instance_count}"
  subnet_id              = "${aws_subnet.SAS_9_4.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "metadata-${count.index + 1}"
    Environment = "SAS 9.4"
  }
}

resource "aws_instance" "mid-tier" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.mid_tier_instance_size, var.environment)}"
  count                  = "${var.mid_tier_instance_count}"
  subnet_id              = "${aws_subnet.SAS_9_4.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "mid-tier-${count.index + 1}"
    Environment = "SAS 9.4"
  }
}

resource "aws_instance" "compute-tier" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.compute_tier_instance_size, var.environment)}"
  count                  = "${var.compute_tier_instance_count}"
  subnet_id              = "${aws_subnet.SAS_9_4.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "compute-tier-${count.index + 1}"
    Environment = "SAS 9.4"
  }
}
