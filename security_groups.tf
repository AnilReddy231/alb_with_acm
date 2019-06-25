resource "aws_security_group" "alb_security_group" {
  name        = "alb_security_group"
  description = "LB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    local.default_tags,
    {
      "Name" = "${var.env_name}-lb-security-group"
    },
  )
}

