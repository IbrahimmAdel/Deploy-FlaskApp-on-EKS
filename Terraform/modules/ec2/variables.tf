variable "sg_vpc_id"{
    description = "VPC ID"
    type = string
}

variable "ec2_subnet_id" {
    description = "Subnet ID where instance will be launched"
    type = string
}

variable "instance_profile"{
    description = "ec2 instance profile"
    type = string
}