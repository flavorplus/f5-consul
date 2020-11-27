# output "address" {
#   value = aws_elb.web.dns_name
# }

output "tags" {
  value       = local.common_tags
  description = "Tag's that have been put all created resources."
}