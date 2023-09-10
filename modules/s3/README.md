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
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. These objects are not recoverable. This only deletes objects when the bucket is destroyed, not when setting this parameter to true. Once this parameter is set to true, there must be a successful terraform apply run before a destroy is required to update this value in the resource state. Without a successful terraform apply after this parameter is set, this flag will have no effect. If setting this field in the same operation that would require replacing the bucket or destroying the bucket, this flag will not work. Additionally when importing a bucket, a successful terraform apply is required to set this value in state before it will take effect on a destroy operation. | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Forces new resource. Name of the bucket. See AWS Documentation for bucket naming rules. | `string` | n/a | yes |
| <a name="input_bucket_object_lock_enabled"></a> [bucket\_object\_lock\_enabled](#input\_bucket\_object\_lock\_enabled) | Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the bucket. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | n/a | yes |
| <a name="input_website_error_document_key"></a> [website\_error\_document\_key](#input\_website\_error\_document\_key) | Conflicts with redirect\_all\_requests\_to. Object key name to use when a 4XX class error occurs. | `string` | `null` | no |
| <a name="input_website_redirect_all_requests_to"></a> [website\_redirect\_all\_requests\_to](#input\_website\_redirect\_all\_requests\_to) | Conflicts with redirect\_all\_requests\_to and routing\_rules. List of rules that define when a redirect is applied and the redirect behavior. The nested CONDITION configuration block supports the following arguments: Optional, Required if key\_prefix\_equals is not specified: http\_error\_code\_returned\_equals - HTTP error code when the redirect is applied. If specified with key\_prefix\_equals, then both must be true for the redirect to be applied. Optional, Required if http\_error\_code\_returned\_equals is not specified: key\_prefix\_equals - Object key name prefix when the redirect is applied. If specified with http\_error\_code\_returned\_equals, then both must be true for the redirect to be applied. The NESTED redirect configuration block supports the following arguments: Optional: host\_name - Host name to use in the redirect request. Optional: http\_redirect\_code - HTTP redirect code to use on the response. Optional: protocol - Protocol to use when redirecting requests. The default is the protocol that is used in the original request. Valid values: http, https. Optional, Conflicts with replace\_key\_with: replace\_key\_prefix\_with - Object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with key\_prefix\_equals set to docs/ and in the redirect set replace\_key\_prefix\_with to /documents. Optional, Conflicts with replace\_key\_prefix\_with: replace\_key\_with - Specific object key to use in the redirect request. For example, redirect request to error.html. | `any` | `[]` | no |
| <a name="input_wesbite_index_document_suffix"></a> [wesbite\_index\_document\_suffix](#input\_wesbite\_index\_document\_suffix) | Required if redirect\_all\_requests\_to is not specified. Name of the index document for the website. Suffix that is appended to a request that is for a directory on the website endpoint. For example, if the suffix is index.html and you make a request to samplebucket/images/, the data that is returned will be for the object with the key name images/index.html. The suffix must not be empty and must not include a slash character. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The domain name of the bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the bucket. |
<!-- END_TF_DOCS -->