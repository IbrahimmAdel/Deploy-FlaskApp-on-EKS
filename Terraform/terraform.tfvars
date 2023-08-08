# providers values 
profile = "default"
region  = "us-east-1"

# network-module values
vpc_cidr = "10.0.0.0/16"

public_subnets = [
  { subnets_cidr = "10.0.1.0/24"
  availability_zone = "us-east-1a" },
  { subnets_cidr = "10.0.2.0/24"
  availability_zone = "us-east-1b" }
]

private_subnets = [
  { subnets_cidr = "10.0.3.0/24"
  availability_zone = "us-east-1a" },
  { subnets_cidr = "10.0.4.0/24"
  availability_zone = "us-east-1b" }
]




