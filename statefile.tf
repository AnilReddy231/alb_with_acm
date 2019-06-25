terraform {
  backend "s3" {
    bucket  = "terraform-trackit"
    key     = "web_acm/"
    region  = "us-west-2"
    encrypt = "true"
  }
}

