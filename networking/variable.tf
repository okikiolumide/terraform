variable "region" {
    default = "us-east-1"
}

provider "aws" {
    region = var.region
}

variable "vpc_cidr" {
    default = "172.16.0.0/16"
}
variable "enable_dns_support" {
    default = "true"
}
variable "enable_dns_hostnames" {
    default ="true"
}
variable "enable_classiclink" {
    default = "false"
}
variable "enable_classiclink_dns_support" {
    default = "false"
}

variable "preferred_number_of_public_subnets" {
default = null
}

variable "preferred_number_of_private_subnets" {
default = null
}

variable "environment" {
    default = "dev"
}
variable "default_tags" {

    default = {
        Env     = "Dev"
        Owner   = "DevOps Team"
        Project = "AWS Infrastructure IaC" 
    }
     
     description = "Default tags for AWS resource"
}