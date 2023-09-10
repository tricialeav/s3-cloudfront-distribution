<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. The ACM certificate must be in US-EAST-1. | `string` | n/a | yes |
| <a name="input_cloudfront_default_origin_aliases"></a> [cloudfront\_default\_origin\_aliases](#input\_cloudfront\_default\_origin\_aliases) | Extra CNAMEs (alternate domain names), if any, for this distribution. | `list(string)` | n/a | yes |
| <a name="input_cloudfront_default_origin_allowed_methods"></a> [cloudfront\_default\_origin\_allowed\_methods](#input\_cloudfront\_default\_origin\_allowed\_methods) | Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. | `list(string)` | n/a | yes |
| <a name="input_cloudfront_default_origin_cached_methods"></a> [cloudfront\_default\_origin\_cached\_methods](#input\_cloudfront\_default\_origin\_cached\_methods) | Controls whether CloudFront caches the response to requests using the specified HTTP methods. | `list(string)` | n/a | yes |
| <a name="input_cloudfront_default_origin_default_ttl"></a> [cloudfront\_default\_origin\_default\_ttl](#input\_cloudfront\_default\_origin\_default\_ttl) | Default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of a Cache-Control max-age or Expires header. | `number` | `3600` | no |
| <a name="input_cloudfront_default_origin_max_ttl"></a> [cloudfront\_default\_origin\_max\_ttl](#input\_cloudfront\_default\_origin\_max\_ttl) | Maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. | `number` | `86400` | no |
| <a name="input_cloudfront_default_origin_min_ttl"></a> [cloudfront\_default\_origin\_min\_ttl](#input\_cloudfront\_default\_origin\_min\_ttl) | Minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds. | `number` | `0` | no |
| <a name="input_cloudfront_origin_default_root_object"></a> [cloudfront\_origin\_default\_root\_object](#input\_cloudfront\_origin\_default\_root\_object) | Object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `string` | `null` | no |
| <a name="input_cloudfront_origin_enabled"></a> [cloudfront\_origin\_enabled](#input\_cloudfront\_origin\_enabled) | Whether the distribution is enabled to accept end user requests for content. | `bool` | `true` | no |
| <a name="input_cloudfront_origin_id"></a> [cloudfront\_origin\_id](#input\_cloudfront\_origin\_id) | Unique identifier for the origin. | `string` | n/a | yes |
| <a name="input_cloudfront_origin_is_ipv6_enabled"></a> [cloudfront\_origin\_is\_ipv6\_enabled](#input\_cloudfront\_origin\_is\_ipv6\_enabled) | Whether the distribution is enabled to accept end user requests for content. | `bool` | `true` | no |
| <a name="input_cloudfront_restriction_locations"></a> [cloudfront\_restriction\_locations](#input\_cloudfront\_restriction\_locations) | ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). If the type is specified as none an empty array can be used. | `list(string)` | `[]` | no |
| <a name="input_cloudfront_restriction_type"></a> [cloudfront\_restriction\_type](#input\_cloudfront\_restriction\_type) | Method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. | `any` | `"none"` | no |
| <a name="input_default_managed_cache_policy"></a> [default\_managed\_cache\_policy](#input\_default\_managed\_cache\_policy) | The ID of the managed AWS cache policy for default Cloudfront origins. | `string` | n/a | yes |
| <a name="input_default_managed_origin_request_policy"></a> [default\_managed\_origin\_request\_policy](#input\_default\_managed\_origin\_request\_policy) | The ID of the managed AWS origin policy for default CloudFront origins. | `string` | `null` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | Ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0. | `any` | `{}` | no |
| <a name="input_origin"></a> [origin](#input\_origin) | One or more origins for this distribution (multiples allowed). Required: domain\_name - DNS domain name of either the S3 bucket, or web site of your custom origin. Optional: custom\_origin\_config - The CloudFront custom origin configuration information. Required: http\_port - HTTP port the custom origin listens on. Required: https\_port - HTTPS port the custom origin listens on. Required: origin\_keepalive\_timeout - The Custom KeepAlive timeout, in seconds. By default, AWS enforces an upper limit of 60. But you can request an increase. Defaults to 5. Required: origin\_protocol\_policy - Origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer. Required: origin\_read\_timeout - The Custom Read timeout, in seconds. By default, AWS enforces an upper limit of 60. But you can request an increase. Defaults to 30. Required: origin\_ssl\_protocols - SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2. | `any` | n/a | yes |
| <a name="input_origin_access_control_description"></a> [origin\_access\_control\_description](#input\_origin\_access\_control\_description) | The description of the Origin Access Control. | `string` | `null` | no |
| <a name="input_origin_access_control_name"></a> [origin\_access\_control\_name](#input\_origin\_access\_control\_name) | A name that identifies the Origin Access Control. | `string` | `null` | no |
| <a name="input_origin_access_control_origin_type"></a> [origin\_access\_control\_origin\_type](#input\_origin\_access\_control\_origin\_type) | The type of origin that this Origin Access Control is for. Valid values are s3, and mediastore. | `string` | `"s3"` | no |
| <a name="input_origin_access_control_signing_behavior"></a> [origin\_access\_control\_signing\_behavior](#input\_origin\_access\_control\_signing\_behavior) | Specifies which requests CloudFront signs. Specify always for the most common use case. Allowed values: always, never, and no-override. | `string` | `"always"` | no |
| <a name="input_origin_access_control_signing_protocol"></a> [origin\_access\_control\_signing\_protocol](#input\_origin\_access\_control\_signing\_protocol) | Determines how CloudFront signs (authenticates) requests. The only valid value is sigv4. | `string` | `"sigv4"` | no |
| <a name="input_ssl_support_method"></a> [ssl\_support\_method](#input\_ssl\_support\_method) | How you want CloudFront to serve HTTPS requests. One of vip or sni-only. Required if you specify acm\_certificate\_arn or iam\_certificate\_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges. | `string` | `"sni-only"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the bucket. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_arn"></a> [cloudfront\_arn](#output\_cloudfront\_arn) | ARN for the distribution. For example: arn:aws:cloudfront::123456789012:distribution/EDFDVBD632BHDS5, where 123456789012 is your AWS account ID. |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net. |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2. |
| <a name="output_cloudfront_id"></a> [cloudfront\_id](#output\_cloudfront\_id) | Identifier for the distribution. For example: EDFDVBD632BHDS5. |
| <a name="output_origin_access_control_id"></a> [origin\_access\_control\_id](#output\_origin\_access\_control\_id) | The unique identifier of this Origin Access Control. |
<!-- END_TF_DOCS -->