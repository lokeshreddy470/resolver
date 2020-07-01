provider "aws" {
  region = "us-west-1"
}

module "r53-outboud" {
  source            = "./terraform-aws-route53-endpoint"
  security_groups   = ["sg-58195625"]
  direction         = "outbound"
  allowed_resolvers = ["192.168.0.0/24"]
  vpc_id            = "vpc-53624235"
  ip_addresses      = [{ subnet_id = "subnet-09179d41" }, { subnet_id = "subnet-e86f1a8e" }]
}

# AWS Route 53 Resolver rules
module "r53-resolver-rules" {
  source               = "./terraform-aws-route53-resolver-rules"
  resolver_endpoint_id = module.r53-outboud.endpoint_id
  rules = [
    { 
      rule_name   = "testing1"
      domain_name = "bar.foo."
      vpc_ids     = ["vpc-04b8eacb99b3e5fce"]
      ips         = ["192.168.10.10", "192.168.10.11"]
     # principals  = ["123456789101", "101987654321"]
    },
    {
      rule_name   = "testing2"
      domain_name = "example.com."
      vpc_ids     = ["vpc-0fffff0123456789"]
      ips         = ["192.168.10.10", "192.168.10.11"]
      #principals  = ["123456789101", "101987654321"]
    }
  ]

}
