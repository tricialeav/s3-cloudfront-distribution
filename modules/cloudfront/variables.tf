variable "default_managed_cache_policy" {
  description = "The ID of the managed AWS cache policy for default Cloudfront origins."
  type        = string
}

variable "default_managed_origin_request_policy" {
  description = "The ID of the managed AWS origin policy for default CloudFront origins."
  type        = string
  default     = null
}

variable "origin_access_control_name" {
  description = "A name that identifies the Origin Access Control."
  type        = string
  default = null
}

variable "origin_access_control_description" {
  description = "The description of the Origin Access Control."
  type        = string
  default = null
}

variable "origin_access_control_origin_type" {
  description = "The type of origin that this Origin Access Control is for. Valid values are s3, and mediastore."
  type        = string
  default     = "s3"
}

variable "origin_access_control_signing_behavior" {
  description = "Specifies which requests CloudFront signs. Specify always for the most common use case. Allowed values: always, never, and no-override."
  type        = string
  default     = "always"
}

variable "origin_access_control_signing_protocol" {
  description = "Determines how CloudFront signs (authenticates) requests. The only valid value is sigv4."
  type        = string
  default     = "sigv4"
}

variable "cloudfront_default_origin_aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  type        = list(string)
}

variable "origin" {
  description = "One or more origins for this distribution (multiples allowed)."
  type        = any
}

variable "cloudfront_origin_id" {
  description = "Unique identifier for the origin."
  type        = string
}

variable "cloudfront_origin_enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  type        = bool
  default     = true
}

variable "cloudfront_origin_is_ipv6_enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  type        = bool
  default     = true
}

variable "cloudfront_origin_default_root_object" {
  description = "Object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  type        = string
  default     = null
}

variable "cloudfront_default_origin_allowed_methods" {
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  type        = list(string)
}

variable "cloudfront_default_origin_cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  type        = list(string)
}

variable "cloudfront_default_origin_min_ttl" {
  description = "Minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  type        = number
  default     = 0
}

variable "cloudfront_default_origin_max_ttl" {
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers."
  type        = number
  default     = 86400
}

variable "cloudfront_default_origin_default_ttl" {
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of a Cache-Control max-age or Expires header."
  type        = number
  default     = 3600
}

variable "ordered_cache_behavior" {
  description = "Ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
  type        = any
  default     = {}
}

variable "cloudfront_restriction_type" {
  description = "Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  type        = any
  default     = "none"
}

variable "cloudfront_restriction_locations" {
  description = "ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). If the type is specified as none an empty array can be used."
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1."
  type        = string
}

variable "ssl_support_method" {
  description = "How you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges."
  type        = string
  default     = "sni-only"
}

variable "tags" {
  description = "Map of tags to assign to the bucket. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
}