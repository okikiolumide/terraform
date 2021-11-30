# Creating launch template for ASG
resource "aws_launch_configuration" "my-test-launch-config" {
    image_id = var.ami
    instance_type = "t2.micro"
    security_groups = [aws_security_group.my-asg-sg.id]
    user_data = <<-EOF
    #!/bin/bash
    yum -y install httpd
    echo "Hello, from Terraform" > /var/www/html/index.html
    service httpd start
    chkconfig httpd on
    EOF
    lifecycle {
        create_before_destroy = true
    }
}

# Creating ASG
resource "aws_autoscaling_group" "public_asg" {
    launch_configuration = aws_launch_configuration.my-test-launch-config.name
    vpc_zone_identifier = [
        
        aws_subnet.public[0].id,
        aws_subnet.public[1].id
    ]
    target_group_arns = [aws_lb_target_group.my-target-group.arn]
    health_check_type = "EC2"
    min_size = 2
    max_size = 10
    tag {
    key = "Name"
    value = "my-test-asg"
    propagate_at_launch = true
}
}