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
     region = "us-east-1"
    
   }

   resource  "aws_instance" "app_server" {
        ami = "ami-00c39f71452c08778"
        instance_type = "t2.micro"

        tags = {
            Name = "Test Server"
        }
   }


   
   
