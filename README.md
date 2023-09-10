<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_certificate"></a> [acm\_certificate](#module\_acm\_certificate) | ./modules/acm | n/a |
| <a name="module_cloudfront_distribution_root"></a> [cloudfront\_distribution\_root](#module\_cloudfront\_distribution\_root) | ./modules/cloudfront | n/a |
| <a name="module_cloudfront_distribution_www"></a> [cloudfront\_distribution\_www](#module\_cloudfront\_distribution\_www) | ./modules/cloudfront | n/a |
| <a name="module_route53_a_records"></a> [route53\_a\_records](#module\_route53\_a\_records) | ./modules/route53 | n/a |
| <a name="module_s3_static_website_root"></a> [s3\_static\_website\_root](#module\_s3\_static\_website\_root) | ./modules/s3 | n/a |
| <a name="module_s3_static_website_www"></a> [s3\_static\_website\_www](#module\_s3\_static\_website\_www) | ./modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_policy.allow_access_to_root](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.allow_access_to_www](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/resources/s3_bucket_policy) | resource |
| [aws_cloudfront_cache_policy.caching_disabled](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_cloudfront_cache_policy.caching_optimized](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_cloudfront_origin_request_policy.all_viewer](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/data-sources/cloudfront_origin_request_policy) | data source |
| [aws_cloudfront_origin_request_policy.cors_custom_origin](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/data-sources/cloudfront_origin_request_policy) | data source |
| [aws_iam_policy_document.allow_access_from_cloudfront_to_root](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.allow_access_from_cloudfront_to_www](https://registry.terraform.io/providers/hashicorp/aws/5.16.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the TLD. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the bucket. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | <pre>{<br>  "environment": "dev",<br>  "project_name": "example project",<br>  "terraform_managed": "true"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->