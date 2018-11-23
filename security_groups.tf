# Base Security Group
resource "aws_security_group" "base" {
  name        = "${var.environment}-base"
  vpc_id      = "${aws_vpc.SAS.id}"
  description = "Security group used to allow SSH between instances in ${var.environment}, and outbound"
}

resource "aws_security_group_rule" "base_allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.base.id}"
}

resource "aws_security_group_rule" "base_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = "${aws_security_group.base.id}"
}

# Bastion Security Group
resource "aws_security_group" "bastion" {
  name        = "${var.environment}-bastion"
  vpc_id      = "${aws_vpc.SAS.id}"
  description = "Security group used to allow SSH between instances in ${var.environment}, and outbound"
}

resource "aws_security_group_rule" "bastion_allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}

resource "aws_security_group_rule" "bastion_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion.id}"
}

# Cas Worker Security Group - aws_security_group.cas_worker.id

resource "aws_security_group" "cas_worker" {
  name        = "${var.environment}-cas-worker"
  vpc_id      = "${aws_vpc.SAS.id}"
  description = "Security group used to allow SSH between instances in ${var.environment}, and outbound"
}

resource "aws_security_group_rule" "cas_worker_allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cas_worker.id}"
}

resource "aws_security_group_rule" "cas_worker_allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cas_worker.id}"
}
