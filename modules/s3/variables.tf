variable "bucket_name" {
  description = "Forces new resource. Name of the bucket. See AWS Documentation for bucket naming rules."
  type        = string
}

variable "bucket_force_destroy" {
  description = "Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error. These objects are not recoverable. This only deletes objects when the bucket is destroyed, not when setting this parameter to true. Once this parameter is set to true, there must be a successful terraform apply run before a destroy is required to update this value in the resource state. Without a successful terraform apply after this parameter is set, this flag will have no effect. If setting this field in the same operation that would require replacing the bucket or destroying the bucket, this flag will not work. Additionally when importing a bucket, a successful terraform apply is required to set this value in state before it will take effect on a destroy operation."
  type        = bool
  default     = false
}

variable "bucket_object_lock_enabled" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled. Valid values are true or false. This argument is not supported in all regions or partitions."
  type        = bool
  default     = false
}

variable "website_error_document" {
  description = "Conflicts with redirect_all_requests_to. Object key name to use when a 4XX class error occurs."
  type        = string
  default     = null
}

variable "website_index_document_suffix" {
  description = "Required if redirect_all_requests_to is not specified. Name of the index document for the website. Suffix that is appended to a request that is for a directory on the website endpoint. For example, if the suffix is index.html and you make a request to samplebucket/images/, the data that is returned will be for the object with the key name images/index.html. The suffix must not be empty and must not include a slash character."
  type        = string
  default     = null
}

variable "website_redirect_all_requests_to_host_name" {
  description = "Required if index_document is not specified. Name of the host where requests are redirected. Optional: protocol - Protocol to use when redirecting requests. The default is the protocol that is used in the original request. Valid values: http, https."
  type        = string
  default     = null
}

variable "website_redirect_all_requests_to_protocol" {
  description = "Required if index_document is not specified. Protocol to use when redirecting requests. The default is the protocol that is used in the original request. Valid values: http, https."
  type        = string
  default     = null
}

variable "website_routing_rules" {
  description = "Conflicts with redirect_all_requests_to and routing_rules. List of rules that define when a redirect is applied and the redirect behavior. The nested CONDITION configuration block supports the following arguments: Optional, Required if key_prefix_equals is not specified: http_error_code_returned_equals - HTTP error code when the redirect is applied. If specified with key_prefix_equals, then both must be true for the redirect to be applied. Optional, Required if http_error_code_returned_equals is not specified: key_prefix_equals - Object key name prefix when the redirect is applied. If specified with http_error_code_returned_equals, then both must be true for the redirect to be applied. The NESTED redirect configuration block supports the following arguments: Optional: host_name - Host name to use in the redirect request. Optional: http_redirect_code - HTTP redirect code to use on the response. Optional: protocol - Protocol to use when redirecting requests. The default is the protocol that is used in the original request. Valid values: http, https. Optional, Conflicts with replace_key_with: replace_key_prefix_with - Object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with key_prefix_equals set to docs/ and in the redirect set replace_key_prefix_with to /documents. Optional, Conflicts with replace_key_prefix_with: replace_key_with - Specific object key to use in the redirect request. For example, redirect request to error.html."
  type        = any
  default     = []
}

variable "bucket_acl" {
  description = "Canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, and bucket-owner-full-control."
  type        = string
  default     = "private"
}

variable "bucket_key_enabled" {
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
  type        = bool
  default     = false
}

variable "bucket_object_website_redirect" {
  description = "Target URL for website redirect."
  type        = string
  default     = null
}

variable "bucket_objects" {
  description = "The objects to add to the bucket on creation."
  type        = list(map(any))
  default     = []
}

variable "tags" {
  description = "Map of tags to assign to the bucket. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
}