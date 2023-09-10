output "origin_access_control_id" {
  description = "The unique identifier of this Origin Access Control."
  value       = aws_cloudfront_origin_access_control.this.id
}

output "cloudfront_id" {
  description = "Identifier for the distribution. For example: EDFDVBD632BHDS5."
  value       = aws_cloudfront_distribution.this.id
}

output "cloudfront_arn" {
  description = "ARN for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID."
  value       = aws_cloudfront_distribution.this.arn
}

output "cloudfront_domain_name" {
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net."
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2."
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}