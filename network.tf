resource "aws_vpc" "default" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = local.common_tags
}

resource "aws_subnet" "default" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.0.0/24"

  tags = local.common_tags
}

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.default.id

#   tags = local.common_tags
# }

# resource "aws_route_table" "r" {
#   vpc_id = aws_vpc.default.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = "aws_route_table"
#   }
# }