resource "aws_alb" "web_alb" {
  name                             = "${var.env_name}-web-alb"
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true
  idle_timeout                     = 3600
  security_groups                  = ["${aws_security_group.alb_security_group.id}"]
  subnets                          = ["${var.public_subnets}"]
  internal                         = false

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-web-alb")
  )}"
}

resource "aws_lb_target_group" "web_tg" {
  name     = "${var.env_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  
  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 5
    path              = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 3
    matcher             = 200
  }

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-web-tg")
  )}"
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = "${aws_alb.web_alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_acm_certificate.smart_cert.arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.web_tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_alb.web_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

