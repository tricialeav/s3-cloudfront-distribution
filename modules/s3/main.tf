resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  force_destroy       = var.bucket_force_destroy
  object_lock_enabled = var.bucket_object_lock_enabled

  tags = var.tags
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.website_redirect_all_requests_to_host_name == null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  error_document {
    key = var.website_error_document
  }

  index_document {
    suffix = var.website_index_document_suffix
  }

  # dynamic "routing_rule" {
  #   for_each = { for k, v in var.website_routing_rules: k => v }

  #   content {
  #     dynamic "condition" {
  #       for_each = routing_rule.value["condition"]

  #       content {
  #         http_error_code_returned_equals = lookup(condition.value, "http_error_code_returned_equals", null)
  #         key_prefix_equals               = lookup(condition.value, "key_prefix_equals", null)
  #       }
  #     }

  #   dynamic "redirect" {
  #     for_each = routing_rule.value["redirect"]

  #     content {
  #       host_name               = lookup(redirect.value, "host_name", null)
  #       http_redirect_code      = lookup(redirect.value, "http_redirect_code", null)
  #       protocol                = lookup(redirect.value, "protocol", null)
  #       replace_key_prefix_with = lookup(redirect.value, "replace_key_prefix_with", null)
  #       replace_key_with        = lookup(redirect.value, "replace_key_with", null)
  #     }
  #   }
  # }
  # }
}

# Due to an AWS CLI limitation, redirect requests cannot be set with error_document or index_document. The only property that can be specified is redirect_all_requests_to in the resource block when used
resource "aws_s3_bucket_website_configuration" "redirect" {
  count  = var.website_redirect_all_requests_to_host_name != null ? 1 : 0
  bucket = aws_s3_bucket.this.id

  redirect_all_requests_to {
    host_name = var.website_redirect_all_requests_to_host_name
    protocol  = var.website_redirect_all_requests_to_protocol
  }
}

resource "aws_s3_object" "object" {
  count              = length(var.bucket_objects)
  bucket             = aws_s3_bucket.this.id
  acl                = lookup(var.bucket_objects[count.index], "acl", null)
  key                = var.bucket_objects[count.index].key
  source             = var.bucket_objects[count.index].source
  content_type       = var.bucket_objects[count.index].content_type
  bucket_key_enabled = var.bucket_key_enabled
  website_redirect   = lookup(var.bucket_objects[count.index], "website_redirect", null)
  tags               = var.tags
}