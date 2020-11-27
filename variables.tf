//HashiCorp reaper specifick variables
variable "owner" {
description = "IAM user responsible for lifecycle of cloud resources used for training"
}

variable "created-by" {
description = "Tag used to identify resources created programmatically by Terraform"
default = "Terraform"
}

variable "sleep-at-night" {
description = "Tag used by reaper to identify resources that can be shutdown at night"
default = true
}

variable "TTL" {
description = "Hours after which resource expires, used by reaper. Do not use any unit. -1 is infinite."
default = "240"
}

//Rest of the VARS
variable "ssh_public_key" {
  description = "The SSH public key to be used for authentication to the EC2 instances."
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-central-1"
}

# Ubuntu Precise 12.04 LTS (x64)
variable "f5_ami" {
  default = {
    eu-west-1 = "ami-674cbc1e"
    us-east-1 = "ami-1d4e7a66"
    us-west-1 = "ami-969ab1f6"
    us-west-2 = "ami-8803e0f0"
  }
}