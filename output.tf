# output "address" {
#   value = aws_elb.web.dns_name
# }

output "tags" {
  value       = local.common_tags
  description = "Tag's that have been put all created resources."
}

output "f5_public_ip" {
  value = aws_instance.f5.public_ip
  description = "The public IP address of the F5."
}