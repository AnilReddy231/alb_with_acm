domain_name = "example.co.za"
env_name = "web-dev"
tags                        = {
    Division                = "Infra"
    Management              = "Terraform"
    MonitorType             = "New Relic"
    }
cert_arns = ["arn:aws:acm:us-east-1:<Account_Number>:certificate/xxxxxxxxx-acbf-4307-80f1-xxxxxxxxxx"]

vpc_id = "vpc-xxxxxxxxxxxxx"
public_subnets = ["subnet-xxxxxxxxxxxx", "subnet-xxxxxxxxxxx"]
app_name = "lensa"