resource "aws_acm_certificate" "smart_cert" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"
}

data "aws_route53_zone" "external" {
  name = "${var.domain_name}"
}
resource "aws_route53_record" "validation" {
  allow_overwrite = true
  name    = "${aws_acm_certificate.smart_cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.smart_cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  records = ["${aws_acm_certificate.smart_cert.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}

resource "aws_acm_certificate_validation" "smart_cert" {
  certificate_arn = "${aws_acm_certificate.smart_cert.arn}"
  validation_record_fqdns = [
    "${aws_route53_record.validation.fqdn}",
  ]
}

# Attach Other Domain's ACM certificates.

resource "aws_lb_listener_certificate" "https_certs" {
  count  = "${length(var.cert_arns)}"
  certificate_arn = "${var.cert_arns[count.index]}"
  listener_arn    = "${aws_lb_listener.https.arn}"
}
