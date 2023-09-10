variable "route53_zone_name" {
  description = "Hosted Zone name of the desired Hosted Zone."
  type        = string
}

variable "domain_name" {
  description = "Domain name for which the certificate should be issued"
  type        = string
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid. This parameter must not be set for certificates that were imported into ACM and then into Terraform."
  type        = string
  default     = null
}

variable "subject_alternative_names" {
  description = "Set of domains that should be SANs in the issued certificate. To remove all elements of a previously configured list, set this value equal to an empty list ([]) or use the terraform taint command to trigger recreation."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map of tags to assign to the bucket. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
}