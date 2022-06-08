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
}

variable "brand" {
  type        = string
  description = "The brand of the service"
}

variable "domains" {
  type        = map(list(string))
  description = "The domains to serve"
}

variable "app_service" {
  type        = string
  description = "The Cloud Run App service"
}

variable "cms_service" {
  type        = string
  description = "The Cloud Run CMS service ID"
}
