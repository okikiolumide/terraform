# Creating AWS internet gateway to connect VPC to the internet

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

 tags = merge(
        var.default_tags,
        {
            Name = format("%s-%s!", aws_vpc.main.id,"IG")

        }
    )
}