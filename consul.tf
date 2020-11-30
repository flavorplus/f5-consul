# AWS ami for Consul
data "aws_ami" "latest_amazon_linux" {
most_recent = true
owners = ["137112412989"] # AWS

  filter {
      name   = "name"
      values = ["amzn2-ami-hvm-*"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name  = "root-device-type"
      values = ["ebs"]
  }
}

resource "aws_security_group" "consul" {
  name        = "consul-${random_pet.name.id}"
  description = "Default security group for Consul."

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

  # Allow internal traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "consul" {
  instance_type = "t2.medium"

  # Lookup the correct AMI
  ami = data.aws_ami.latest_amazon_linux.id

  # The SSH key used to login after setup
  key_name = aws_key_pair.default.id

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids      = [aws_security_group.consul.id]
  subnet_id                   = aws_subnet.default.id
  associate_public_ip_address = true

  #Instance tags
  tags = local.common_tags
}