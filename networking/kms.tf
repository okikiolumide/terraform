resource "aws_kms_key" "kms" {
    description = "KMS key "
    policy = <<EOF
        {
        "Version": "2012-10-17",
        "Id": "kms-key-policy",
        "Statement": [
            {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {"AWS": "arn:aws:iam::${var.account_no}:root"},
            "Action": "kms:*",
            "Resource": "*"
            }
        ]
    }
    EOF
    }

    resource "aws_kms_alias" "alias" {
         name = "alias/kms"
         target_key_id = aws_kms_key.kms.key_id
}
