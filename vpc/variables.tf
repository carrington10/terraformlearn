#subnet range public 
variable "public_subnet_cidrs" {
    type = list(string)
    description = "public subnet cidr values"
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}
# subnet range private
variable "private_subnet_cidrs" {
    type = list(string)
    description = "Private subnet cidr values"
    default = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
}

# az zones
variable "azs"{
    type = list(string)
    description = "Availability zones"
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}