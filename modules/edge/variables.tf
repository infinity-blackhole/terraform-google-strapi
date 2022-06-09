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

variable "domains" {
  type        = map(list(string))
  description = "The domains to serve"
}

variable "services" {
  type        = map(string)
  description = "The services to expose"
}
