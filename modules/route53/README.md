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
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_route53_records"></a> [route53\_records](#input\_route53\_records) | A list of record information for Route53. Required: zone\_id - The ID of the hosted zone to contain this record. Required: name - The name of the record. Required: type - The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. Required: alias - Conflicts with ttl & records and requires the following: name - DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone, zone\_id - Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone, and evaluate\_target\_health - Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. | `any` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | Hosted Zone name of the desired Hosted Zone. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->