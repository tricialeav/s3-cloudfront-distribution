output "bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "The ARN of the bucket."
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "The domain name of the bucket."
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "value"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}


output "website_domain" {
  description = "Domain of the website endpoint. This is used to create Route 53 alias records."
  value       = aws_s3_bucket_website_configuration.redirect.*.website_domain
}

output "website_endpoint" {
  description = "Website endpoint."
  value       = aws_s3_bucket_website_configuration.redirect.*.website_endpoint
}