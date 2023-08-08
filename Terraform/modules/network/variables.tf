variable "vpc_cidr" { 
    description = "VPC CIDR"
    type = string 
    }

variable "pub_subnets"{
  description = "public subnets info"
  type        = list(object({
    subnets_cidr      = string
    availability_zone = string
  }))
}

variable "priv_subnets"{
description = "private subnets info"
  type = list(object({
    subnets_cidr = string
    availability_zone = string
  }))
}


