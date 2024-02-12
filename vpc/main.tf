
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}

# create a vpc 

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = local.common_tags
}
#creates public subnets
resource "aws_subnet" "public_subnets"{
    count = length(var.public_subnet_cidrs)
    vpc_id =  aws_vpc.main.id
    cidr_block = element(var.public_subnet_cidrs,count.index)
    tags = {
        Name = "public subnet ${count.index + 1}"
    }
}
#creates private subnets
resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.private_subnet_cidrs,count.index)
    tags = {
        Name = "private subnet ${count.index + 1}"
    }
}

 
