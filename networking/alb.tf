# Creating ALB for public facing instances

resource "aws_lb" "my-aws-alb" {
    name = "my-test-alb"
    internal = false
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    security_groups = [
        aws_security_group.my-alb-sg.id,
    ]
    subnets = [
        # aws_subnet.public.*.id
        aws_subnet.public[0].id,
        aws_subnet.public[1].id
    ]
    tags = {
        Name = "my-test-alb"
    }

}

# Creating ALB Target group and Health Check

resource "aws_lb_target_group" "my-target-group" {
    health_check {
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2
}
    name = "my-test-tg"
    port = 80
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = aws_vpc.main.id
}

# Creating ALB Listener
resource "aws_lb_listener" "my-test-alb-listner" {
    load_balancer_arn = aws_lb.my-aws-alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.my-target-group.arn
    }
}

# Creating private subnet ALB

resource "aws_lb" "my-aws-alb-private" {
    name = "my-test-alb-private"
    internal = true
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    security_groups = [
        aws_security_group.my-alb-sg.id,
    ]
    subnets = [
        aws_subnet.private[0].id,
        aws_subnet.private[1].id
    ]

    tags = {
        Name = "my-test-alb-private"
    }
   
}

# Creating ALB Listener
resource "aws_lb_listener" "my-test-alb-listener" {
    load_balancer_arn = aws_lb.my-aws-alb-private.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.my-target-group.arn
    }
}

