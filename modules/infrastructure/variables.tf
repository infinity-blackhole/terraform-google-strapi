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

variable "image" {
  type        = string
  description = "The image to use for the service"
  default     = "gcr.io/cloudrun/placeholder"
}

variable "port" {
  type        = number
  description = "The port to expose the service on"
  default     = 1337
}

variable "max_instances" {
  type        = number
  description = "The maximum number of instances to run"
  default     = 1
}
