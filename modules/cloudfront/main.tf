resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.origin_access_control_name
  description                       = var.origin_access_control_description
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "this" {
  aliases     = var.cloudfront_default_origin_aliases
  price_class = "PriceClass_100"

  origin {
    domain_name              = var.cloudfront_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = join("-", [var.cloudfront_origin_id, "origin"])
  }

  enabled             = var.cloudfront_origin_enabled
  default_root_object = var.cloudfront_origin_default_root_object

  # Due to a provider bug, the default cache behavior does not deploy properly.
  default_cache_behavior {
    allowed_methods  = var.cloudfront_default_origin_allowed_methods
    cached_methods   = var.cloudfront_default_origin_cached_methods
    target_origin_id = join("-", [var.cloudfront_origin_id, "origin"])

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.cloudfront_default_origin_min_ttl
    default_ttl            = var.cloudfront_default_origin_default_ttl
    max_ttl                = var.cloudfront_default_origin_max_ttl
    cache_policy_id        = var.default_managed_cache_policy
    # origin_request_policy_id = var.default_managed_origin_request_policy
  }

  # Cache behavior with precedence 0
  # Required as Cloudfront does not default to index.html if not using the website endpoint (HTTP)
  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behavior

    content {
      path_pattern     = ordered_cache_behavior.value["path_pattern"]
      allowed_methods  = ordered_cache_behavior.value["allowed_methods"]
      cached_methods   = ordered_cache_behavior.value["cached_methods"]
      target_origin_id = join("-", [var.cloudfront_origin_id, "origin"])

      min_ttl                = ordered_cache_behavior.value["min_ttl"]
      default_ttl            = ordered_cache_behavior.value["default_ttl"]
      max_ttl                = ordered_cache_behavior.value["max_ttl"]
      compress               = ordered_cache_behavior.value["compress"]
      viewer_protocol_policy = ordered_cache_behavior.value["viewer_protocol_policy"]
      cache_policy_id        = ordered_cache_behavior.value["cache_policy_id"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_restriction_type
      locations        = var.cloudfront_restriction_locations
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = var.ssl_support_method
    minimum_protocol_version = "TLSv1.2_2021"
  }

}