variable "region" {}

provider "aws" {
    region = var.region
}

variable "vpc_cidr" {}
variable "enable_dns_support" {}
variable "enable_dns_hostnames" {}
variable "enable_classiclink" {}
variable "enable_classiclink_dns_support" {}

variable "preferred_number_of_public_subnets" {}

variable "preferred_number_of_private_subnets" {}

variable "environment" {}

variable "ami" {}

variable "instance_type" {}

variable "key_name" {} 

variable "account_no" {}


variable "default_tags" {

    default = {
        Environment     = "Dev"
        ManagedBy       = "DevOps Team"
        Project         = "AWS Infrastructure IaC"
         

    }
     
     description        = "Default tags for AWS resource"
}