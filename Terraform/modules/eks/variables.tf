variable "eni_subnet_ids" {
    description = "subnets id where cluster network interfaces will be placed"
    type = list(string)
}

variable "nodegroup_subnets_id" {
    description = "subnets where worker nodes will be placed"
    type = list(string)
}
