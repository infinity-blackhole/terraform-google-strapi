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

variable "docker_container_image" {
  type        = string
  description = "The Docker container image name"
  default     = "gcr.io/cloud-builders/docker@sha256:f42c653aeae55fea4cd318a9443823c77243929dae6bb784b9eef21e1ab40d09"
}
