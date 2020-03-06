resource "aws_elb" "this" {
  name            = "${var.elb_name}"
  subnets         = ["${var.subnets}"]
  internal        = false
  security_groups = ["${var.security_group}"]

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "${var.protocol}"
    lb_port           = "${var.lb_port}"
    lb_protocol       = "${var.protocol}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.instance_port}/"
    interval            = 30
  }

  instances                   = ["${var.instances}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = "${merge(map("Name", format("%s", var.elb_name)), var.tags)}"
}
