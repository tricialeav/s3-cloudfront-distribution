variable "domain_name" {
  description = "The name of the TLD."
  type        = string
}

variable "tags" {
  description = "Map of tags to assign to the bucket. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default = {
    project_name      = "example project"
    environment       = "dev"
    terraform_managed = "true"
  }
}