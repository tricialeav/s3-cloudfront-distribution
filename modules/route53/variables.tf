variable "route53_zone_name" {
  description = "Hosted Zone name of the desired Hosted Zone."
  type        = string
}

variable "route53_records" {
  description = "A list of record information for Route53. Required: zone_id - The ID of the hosted zone to contain this record. Required: name - The name of the record. Required: type - The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. Required: alias - Conflicts with ttl & records and requires the following: name - DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone, zone_id - Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone, and evaluate_target_health - Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set."
  type        = any
}