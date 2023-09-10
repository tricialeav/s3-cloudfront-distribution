# Assumption 1: We are using Route53 and Cloudfront to prevent public access to the bucket contents
# Assumption 2: The bucket contents should be encrypted via the default AWS S3 object encryption
# Assumption 3: The bucket is not being set up for lifecycle configurations
# Assumption 4: The bucket will not have versioning enabled
# Assumption 5: The bucket will not have logging/metrics enabled
# Assumption 6: We do not need to lock objects and have no WORM requirements for retention
# Assumption 7: The AWS account has a registered domain that is managed in Route53
# Assumption 8: We will not use Terraform to manage the domain as it cannot create nor delete the resource in the current version of the AWS provider for Route53: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53domains_registered_domain
# Assumption 9: The route53 records and routing rules are not changing frequently and can be passed in as a list
# Assumption 10: We are using simple routing in Route53
# Assumption 11: We are using Terraform to manage the static website files for example purposes. In a production environment we would manage these separately in a git repo and deploy via CI/CD pipeline.
# Assumption 12: We are not using a WAF
# Assumption 13: Each Cloudfront distribution is serving a single S3 origin
# Assumption 14: We are using us-east-1 for simplicity with the ACM certificate

data "aws_iam_policy_document" "allow_access_from_cloudfront_to_www" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      join("", [module.s3_static_website_www.bucket_arn, "/*"]),
      module.s3_static_website_www.bucket_arn
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [module.cloudfront_distribution_www.cloudfront_arn]
    }
  }
}

data "aws_iam_policy_document" "allow_access_from_cloudfront_to_root" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      join("", [module.s3_static_website_root.bucket_arn, "/*"])
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        module.cloudfront_distribution_root.cloudfront_arn,
        module.cloudfront_distribution_www.cloudfront_arn,
        module.s3_static_website_www.bucket_arn
      ]
    }
  }
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "Managed-AllViewer"
}

data "aws_cloudfront_origin_request_policy" "cors_s3_origin" {
  name = "Managed-CORS-S3Origin"
}

module "s3_static_website_root" {
  source                        = "./modules/s3"
  bucket_name                   = var.domain_name
  bucket_force_destroy          = true
  website_error_document        = "error.html"
  website_index_document_suffix = "index.html"

  bucket_objects = [
    {
      key          = "index.html"
      source       = "./website/index.html"
      content_type = "text/html"
    },
    {
      key          = "error.html"
      source       = "./website/error.html"
      content_type = "text/html"
    }
  ]

  tags = var.tags
}

module "s3_static_website_www" {
  source                                     = "./modules/s3"
  bucket_name                                = join(".", ["www", var.domain_name])
  bucket_force_destroy                       = true
  website_redirect_all_requests_to_host_name = var.domain_name
  website_redirect_all_requests_to_protocol  = "https"

  # website_routing_rules = [
  #   {
  #     condition = {
  #       http_error_code_returned_equals = "404"
  #     }
  #     redirect = {
  #       replace_key_with = "404.html"
  #     }
  #   },
  #   {
  #     condition = {
  #       key_prefix_equals = "routing_example"
  #     }
  #     redirect = {
  #       replace_key_with = "routing_example.html"
  #     }
  #   }
  # ]

  tags = var.tags
}

module "route53_a_records" {
  source            = "./modules/route53"
  route53_zone_name = var.domain_name
  route53_records = [
    {
      name = join(".", ["*", var.domain_name])
      type = "A"
      alias = {
        name                   = module.cloudfront_distribution_www.cloudfront_domain_name
        zone_id                = module.cloudfront_distribution_www.cloudfront_hosted_zone_id
        evaluate_target_health = false
      }
    },
    {
      name = var.domain_name
      type = "A"
      alias = {
        name                   = module.cloudfront_distribution_root.cloudfront_domain_name
        zone_id                = module.cloudfront_distribution_root.cloudfront_hosted_zone_id
        evaluate_target_health = false
      }
    }
  ]
}

module "acm_certificate" {
  source                    = "./modules/acm"
  domain_name               = var.domain_name
  route53_zone_name         = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = [join(".", ["*", var.domain_name])]
  tags                      = var.tags
}

module "cloudfront_distribution_www" {
  source                                    = "./modules/cloudfront"
  default_managed_cache_policy              = data.aws_cloudfront_cache_policy.caching_disabled.id
  origin_access_control_name                = join("-", [split(".", var.domain_name)[0], "www"])
  origin_access_control_description         = "Origin Access Control for demo S3 website subdomain"
  cloudfront_default_origin_aliases         = [join(".", ["www", var.domain_name])]
  cloudfront_default_origin_allowed_methods = ["GET", "HEAD"]
  cloudfront_default_origin_cached_methods  = ["GET", "HEAD"]
  acm_certificate_arn                       = module.acm_certificate.cert_arn
  cloudfront_domain_name                    = module.s3_static_website_www.bucket_regional_domain_name
  cloudfront_origin_id                      = join(".", ["www", split(".", var.domain_name)[0]])
  cloudfront_default_origin_max_ttl         = 0
  cloudfront_default_origin_default_ttl     = 0

  tags = var.tags

  depends_on = [module.acm_certificate]
}

module "cloudfront_distribution_root" {
  source                                    = "./modules/cloudfront"
  default_managed_cache_policy              = data.aws_cloudfront_cache_policy.caching_optimized.id
  origin_access_control_name                = split(".", var.domain_name)[0]
  origin_access_control_description         = "Origin Access Control for demo S3 website root"
  cloudfront_default_origin_aliases         = [var.domain_name]
  cloudfront_default_origin_allowed_methods = ["GET", "HEAD"]
  cloudfront_default_origin_cached_methods  = ["GET", "HEAD"]
  acm_certificate_arn                       = module.acm_certificate.cert_arn
  cloudfront_domain_name                    = module.s3_static_website_root.bucket_regional_domain_name
  cloudfront_origin_id                      = split(".", var.domain_name)[0]
  cloudfront_origin_default_root_object     = "index.html"

  ordered_cache_behavior = [
    {
      path_pattern           = "/index.html"
      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      min_ttl                = 0
      default_ttl            = 0
      max_ttl                = 0
      compress               = false
      viewer_protocol_policy = "redirect-to-https"
      cache_policy_id        = data.aws_cloudfront_cache_policy.caching_disabled.id
    }
  ]

  tags = var.tags

  depends_on = [module.acm_certificate]
}

# Add an allow policy to our bucket(s) once the distribution has been created
resource "aws_s3_bucket_policy" "allow_access_to_root" {
  bucket = module.s3_static_website_root.bucket_id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront_to_root.json
}

resource "aws_s3_bucket_policy" "allow_access_to_www" {
  bucket = module.s3_static_website_www.bucket_id
  policy = data.aws_iam_policy_document.allow_access_from_cloudfront_to_www.json
}
