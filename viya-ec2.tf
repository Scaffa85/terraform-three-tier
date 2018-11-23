resource "aws_instance" "viya-services" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.viya_services_instance_size, var.environment)}"
  count                  = "${var.viya_services_instance_count}"
  subnet_id              = "${aws_subnet.SAS_VIYA.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "viya-services-${count.index + 1}"
    Environment = "SAS VIYA"
  }
}

resource "aws_instance" "cas-mid-tier" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.cas_mid_tier_instance_size, var.environment)}"
  count                  = "${var.cas_mid_tier_instance_count}"
  subnet_id              = "${aws_subnet.SAS_VIYA.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "cas-mid-${count.index + 1}"
    Environment = "SAS VIYA"
  }
}

resource "aws_instance" "cas-worker-tier" {
  ami                    = "${lookup(var.rhel_amis, var.region)}"
  instance_type          = "${lookup(var.cas_worker_instance_size, var.environment)}"
  count                  = "${var.cas_worker_instance_count}"
  subnet_id              = "${aws_subnet.SAS_VIYA.id}"
  vpc_security_group_ids = ["${aws_security_group.base.id}"]
  key_name               = "${var.deployer-key-name}"

  tags {
    Name        = "cas-worker-${count.index + 1}"
    Environment = "SAS VIYA"
  }
}
