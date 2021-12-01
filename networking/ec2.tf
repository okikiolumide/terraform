resource "aws_instance" "public" {
    count = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
    key_name = var.key_name
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [
        aws_security_group.bastion_sg.id
    ]

    user_data = <<EOF
      #!/bin/bash
      echo "Hello, welcome to Bastion server"
      # echo "updating server and installing packages"
      # apt update -y
      # apt install software-properties-common -y
      # add-apt-repository --yes --update ppa:ansible/ansible
      # apt install -y ansible git
      EOF
  
    
    lifecycle {
    create_before_destroy = true
  }

    subnet_id = element(aws_subnet.public.*.id,count.index)
    associate_public_ip_address = true
    source_dest_check = false

    tags = {
        Name = "bastion-TF${count.index}"
    }
}   

# Creating Private subnet EC2 instances
resource "aws_instance" "private" {
  count = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
  key_name = var.key_name
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [
      aws_security_group.private_sg.id
  ]
  subnet_id = element(aws_subnet.private.*.id,count.index)
  associate_public_ip_address = false
  source_dest_check = false
  
    tags = {
      Name = "private-Test${count.index}"
   }
}