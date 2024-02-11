variable "ami_list" {
    type = list
    description = " ami id list for deployment"
    default = ["ami-00c39f71452c08778"]
}

variable "aw_region" {
    type = list
    description = " awsa region to deploy"
    default = ["us-east-1","us-east-2","us-west-1"]
}