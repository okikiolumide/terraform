
# Get list of Availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

#Create VPC

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_classiclink = var.enable_classiclink
    enable_classiclink_dns_support = var.enable_classiclink_dns_support
}

# Create public subnets
resource "aws_subnet" "public" {
    count =  var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index+5)
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = merge(
        var.default_tags,
        {
            Name = format("PublicSubnet-%s", count.index+1)
        }
    )
}

#Create private subnets
resource "aws_subnet" "private" {
    count =  var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index+2)
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = merge(
        var.default_tags,
        {
            Name = format("PrivateSubnet-%s", count.index+1)
        }
    )

}

# RDS Subnet
resource "aws_db_subnet_group" "db_subnet" {
    name       = "main"
    subnet_ids = [
        aws_subnet.private[0].id,
        aws_subnet.private[1].id
    ]

  tags = {
    Name = "My DB subnet group"
  }
}