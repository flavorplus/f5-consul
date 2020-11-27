terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

provider "random" {
  version = "3.0.0"
}

resource "random_pet" "name" {
  length = 2
  prefix = "F5_Consul_Demo-"
}



locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name            = random_pet.name.id
    owner           = var.owner
    created-by      = var.created-by
    sleep-at-night  = var.sleep-at-night
    TTL             = var.TTL
  }
}