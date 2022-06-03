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

variable "brand" {
  type        = string
  description = "The brand of the service"
}

variable "domains" {
  type        = list(string)
  description = "The domains to serve"
}
