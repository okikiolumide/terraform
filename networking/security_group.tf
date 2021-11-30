#

resource "aws_security_group" "bastion_sg" {
    name = "vpc_web_sg"
    description = "Allow incoming HTTP connections."
     vpc_id = aws_vpc.main.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
    Name = "bastion-SG"
    Environment = var.environment
    }
}

resource "aws_security_group" "my-alb-sg" {
    name = "my-alb-sg"
    vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "inbound_http" {
    from_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.my-alb-sg.id
    to_port = 80
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_all" {
    from_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.my-alb-sg.id
    to_port = 0
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}

# Auto Scaling Group - SG
resource "aws_security_group" "my-asg-sg" {
    name = "my-asg-sg"
    vpc_id = aws_vpc.main.id
}
resource "aws_security_group_rule" "inbound_ssh-asg" {
    from_port = 22
    protocol = "tcp"
    security_group_id = aws_security_group.my-asg-sg.id
    to_port = 22
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "inbound_http-asg" {
    from_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.my-asg-sg.id
    to_port = 80
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "outbound_all-asg" {
    from_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.my-asg-sg.id
    to_port = 0
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}