variable "project" {
  type        = string
  description = "The Google Cloud project ID"
}

variable "region" {
  type        = string
  description = "The Google Cloud region"
}

variable "name" {
  type        = string
  description = "The full name of the service"
  default     = "strapi"
}

variable "repository" {
  type        = string
  description = "The repository to use for the service"
}

variable "display_name" {
  type        = string
  description = "The display name of the service"
}
variable "tag" {
  type        = string
  description = "The tag to use for the release"
  default     = "^v([0-9]+)\\.([0-9]+)\\.([0-9]+)(?:\\+[0-9A-Za-z-]+)?$"
}

variable "filename" {
  type        = string
  description = "The filename of the Cloud Build template"
  default     = "delivery.cloudbuild.yaml"
}
