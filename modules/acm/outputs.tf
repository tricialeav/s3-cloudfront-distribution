output "cert_arn" {
  description = "ARN of the certificate."
  value       = aws_acm_certificate.this.arn
}