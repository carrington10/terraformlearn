
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
    availability_zone = element(var.azs,count.index)
    tags = {
        Name = "public subnet ${count.index + 1}"
    }
}
#creates private subnets
resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.private_subnet_cidrs,count.index)
    availability_zone = element(var.azs,count.index)
    tags = {
        Name = "private subnet ${count.index + 1}"
    }
}

# create interanl gateway
resource "aws_internet_gateway" "gw"{
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "internal gateway"
    }
}
# create second route table to connect public subnets to the internet
resource "aws_route_table" "second_rt" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }

        tags = {
            Name = "2nd route table"
        }
}

# associate public subnets with the second route table ( gives internet access)

resource "aws_route_table_association" "public_subnet_asso" {
    count = length(var.public_subnet_cidrs)
    subnet_id = element(aws_subnet.public_subnets[*].id,count.index)
    route_table_id = aws_route_table.second_rt.id
}

 
