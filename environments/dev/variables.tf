variable "project" {
  type        = string
  description = "The Google Cloud project ID"
  default     = "par-unicorn-dev"
}

variable "multi_region" {
  type        = string
  description = "The Google Cloud multi region"
  default     = "EU"
}

variable "region" {
  type        = string
  description = "The Google Cloud region"
  default     = "europe-west1"
}

variable "name" {
  type        = string
  description = "The full name of the service"
  default     = "strapi"
}

variable "zone" {
  type        = string
  description = "The Google Cloud zone"
  default     = "europe-west1-b"
}

variable "graphql_url" {
  type        = string
  description = "The GraphQL URL"
  default     = "https://unicorn.dev.cms.sfeirfactory.com/graphql"
}

variable "services" {
  type = map(object({
    name         = string
    display_name = string
    repository   = string
  }))
  description = "The services to deploy"
  default = {
    cms = {
      name         = "strapi-cms"
      display_name = "CMS"
      repository   = "the-unicorn-cms-mirrored"
    }
    front = {
      name         = "strapi-front"
      display_name = "Front"
      repository   = "the-unicorn-front-mirrored"
    }
  }
}

variable "domains" {
  type        = map(list(string))
  description = "The domains to serve"
  default = {
    front = [
      "unicorn.dev.sfeirfactory.com"
    ]
    cms = [
      "unicorn.dev.cms.sfeirfactory.com"
    ]
  }
}
