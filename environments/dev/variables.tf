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

variable "brand" {
  type        = string
  description = "The brand of the service"
  default     = "202922177550"
}

variable "domains" {
  type        = map(list(string))
  description = "The domains to serve"
  default = {
    front = [
      "unicorn.sfeir.shikanime.studio",
      "unicorn.dev.sfeirfactory.com"
    ]
    cms = [
      "cms.unicorn.sfeir.shikanime.studio",
      "unicorn.dev.cms.sfeirfactory.com"
    ]
  }
}
