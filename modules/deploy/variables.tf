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

variable "branch" {
  type        = string
  description = "The trunk branch to use for the service"
  default     = "^trunk$"
}

variable "repository" {
  type        = string
  description = "The repository to use for the service"
}

variable "display_name" {
  type        = string
  description = "The display name of the service"
}

variable "artifact_registry_repository" {
  type        = string
  description = "The repository to use for the service"
}
