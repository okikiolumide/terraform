# route table with target as internet gateway 

resource "aws_route_table" "public_route_table" {
    depends_on = [
        aws_vpc.main,
        aws_internet_gateway.ig,
    ]

    vpc_id         = aws_vpc.main.id
    
    route {  
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }

    tags = {
                Name = format("Public-RouteTable-%s", var.environment)
    } 

}

# Associate public subnet to Internet Gateway

resource "aws_route_table_association" "public" {
    depends_on = [
        aws_subnet.public,
        aws_route_table.public_route_table
    ]

    count           = length(aws_subnet.public[*].id)
    subnet_id       = element(aws_subnet.public[*].id, count.index)
    route_table_id  = aws_route_table.public_route_table.id
}

# Route table with target as NAT gateway

resource "aws_route_table" "private_route_table" {
    depends_on = [
        aws_vpc.main,
       
    ]

    vpc_id         = aws_vpc.main.id
    
    route {  
        cidr_block = "0.0.0.0/0"
        gateway_id = element(aws_nat_gateway.nat.*.id, 0)
    }

    tags = {
        Name = format("Private-RouteTable-%s", var.environment)
    } 

}

# Associate public subnet to NAT Gateway

resource "aws_route_table_association" "private" {
    depends_on = [
        aws_subnet.private,
        aws_route_table.private_route_table
    ]

    count = length(aws_subnet.private[*].id)
    subnet_id = element(aws_subnet.private[*].id, count.index)
    route_table_id  = aws_route_table.private_route_table.id
}
