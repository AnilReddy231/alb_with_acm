variable "domain_name" {
}

variable "cert_arns" {
  type = list(string)
}

variable "env_name" {
}

variable "tags" {
  type = map(string)
}

variable "app_name" {
}

variable "vpc_id" {
}

variable "public_subnets" {
  type = list(string)
}

