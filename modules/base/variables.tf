variable "project" {
  type        = string
  description = "The Google Cloud project ID"
}

variable "name" {
  type        = string
  description = "The full name of the service"
  default     = "strapi"
}
