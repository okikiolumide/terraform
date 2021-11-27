resource "aws_eip" "nat_eip" {
        count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
        vpc = true
        depends_on = [aws_internet_gateway.ig]
            tags = merge(
                var.default_tags,
            {
                Name = format("EIP-%s",var.environment)
            }
            )
    }
        resource "aws_nat_gateway" "nat" {
        count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
        allocation_id = aws_eip.nat_eip[count.index].id
        subnet_id = element(aws_subnet.public.*.id, count.index)
        depends_on = [aws_internet_gateway.ig]
            tags = merge(
                var.default_tags,
            {
            Name = format("Nat-%s",var.environment)
            }
        )
    }
