resource "aws_instance" "private" {
    count = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
    key_name = var.key_name
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [
        aws_security_group.master_sg.id
    ]
    subnet_id = element(aws_subnet.private.*.id,count.index)
    associate_public_ip_address = false
    source_dest_check = false

    tags = {
        Name = "master-TF${count.index}"
    }
}   