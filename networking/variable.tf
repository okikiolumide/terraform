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

variable "ami" {
    default = "ami-083654bd07b5da81d"
}

variable "instance_type" {
   default = "t2.micro"
}

variable "key_name" {
    default = "master-key"
} 

variable "account_no" {
    default = "570098017106"
}

variable "kms_arn" {
    default = "arn:aws:iam::570098017106:root"
}

variable "default_tags" {

    default = {
        Environment     = "Dev"
        ManagedBy       = "DevOps Team"
        Project         = "AWS Infrastructure IaC"
         

    }
     
     description        = "Default tags for AWS resource"
}