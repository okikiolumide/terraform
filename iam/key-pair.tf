
# Create Key pair using Key pair Module on AWS
# run Terraform init before applying

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "master-key"
  public_key = tls_private_key.this.public_key_openssh
}

