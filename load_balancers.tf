resource "aws_lb" "cas_worker_lb" {
  name               = "cas-worker-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${aws_subnet.SAS_9_4.id}"]

  enable_deletion_protection = "${lookup(var.deletion_protection_on, var.environment)}"

  tags {
    Name = "${var.environment} - SAS 9.4"
  }
}

resource "aws_lb_listener" "cas_worker_front_end" {
  load_balancer_arn = "${aws_lb.cas_worker_lb.arn}"
  port              = "${var.cas_worker_lb_port}"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.cas_worker_target_group.arn}"
  }
}

resource "aws_lb_target_group" "cas_worker_target_group" {
  name       = "CAS-worker-target-group"
  port       = "${var.cas_worker_lb_port}"
  protocol   = "TCP"
  vpc_id     = "${aws_vpc.SAS.id}"
  stickiness = []

  health_check {
    protocol            = "TCP"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    path                = ""
    matcher             = ""
  }
}

resource "aws_lb_target_group_attachment" "cas_worker_target_group_attachment" {
  count            = "${var.cas_worker_instance_count}"
  target_group_arn = "${aws_lb_target_group.cas_worker_target_group.arn}"
  target_id        = "${element(split(",", join(",", aws_instance.compute-tier.*.id)), count.index)}"
  port             = "${var.cas_worker_lb_port}"
}
