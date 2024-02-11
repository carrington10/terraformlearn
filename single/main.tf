# creates a single instance in aws 
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
   }

   required_version = ">= 1.2.0"
}

 provider "aws" {
     region = aw_region[0]
    
   }

   resource  "aws_instance" "app_server" {
        ami = var.ami_list[0]
        instance_type = "t2.micro"

        tags = {
            Name = "Test Server"
        }
   }


   
   
