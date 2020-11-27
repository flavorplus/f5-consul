# AWS ami's for the F5
locals {
  amis = {
    eu-central-1 = "ami-052749e2b5082eced"
  }
}

resource "aws_security_group" "f5" {
  name        = random_pet.name.id
  description = "Default security group for the F5."

  vpc_id = aws_vpc.default.id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Web UI access form anywhere
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "f5" {
  instance_type = "t2.medium"

  # Lookup the correct AMI based on the region
  # we specified
  ami = local.amis[var.aws_region]

  # The SSH key used to login after setup
  key_name = aws_key_pair.default

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = [aws_security_group.f5.id]
  subnet_id              = aws_subnet.default.id

  #Instance tags
  tags = local.common_tags
}