# Creating IAM Role for EC2

resource "aws_iam_role" "ec2_instance_role" {
        name = "ec2_instance_role"
            assume_role_policy = <<EOF
{
                    "Version": "2012-10-17",
                    "Statement": [
                {
                    "Action": "sts:AssumeRole",
                    "Principal": {
                    "Service": "ec2.amazonaws.com"
                },
                    "Effect": "Allow",
                    "Sid": ""
                }
            ]
}
EOF
        tags = {
        Name = "aws assume role"
        Environment = var.environment
        }
}

# Creating EC2 instance Policy 
resource "aws_iam_policy" "policy" {
        name = "ec2_instance_policy"
        description = "A test policy"

        policy = jsonencode({
                
                    "Version": "2012-10-17",
                    "Statement":[
                        {
                        Action:[
                            "ec2:Describe*"
                        ],
                            Effect: "Allow",
                            Resource: "*"
                        }
                    ]
                })

        tags = {
        Name = "aws assume policy"
        Environment = var.environment
            
    }
}

# Attach Policy to Role

resource "aws_iam_role_policy_attachment" "test-attach" {
    role = aws_iam_role.ec2_instance_role.name
    policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "ip" {
    name = "aws_instance_profile_test"
    role = aws_iam_role.ec2_instance_role.name
}

