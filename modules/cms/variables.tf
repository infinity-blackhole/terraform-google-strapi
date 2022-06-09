variable "project" {
  type        = string
  description = "The Google Cloud project ID"
}

variable "multi_region" {
  type        = string
  description = "The Google Cloud multi region"
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
  description = "The Docker image to use"
  default     = "gcr.io/cloudrun/placeholder"
}

variable "cpu" {
  type        = string
  description = "The amount of CPU to allocate to the container"
  default     = "1000m"
}

variable "memory" {
  type        = string
  description = "The amount of memory to allocate to the container"
  default     = "256Mi"
}

variable "max_instances" {
  type        = number
  description = "The maximum number of instances to run"
  default     = 1
}

variable "client_name" {
  type        = string
  description = "The name of the client"
  default     = "gcloud"
}

variable "client_version" {
  type        = string
  description = "The version of the client"
  default     = "381.0.0"
}

variable "database_instance" {
  type        = string
  description = "The name of the database instance"
}

variable "database_connection_name" {
  type        = string
  description = "The name of the database connection"
}

variable "network" {
  type        = string
  description = "The name of the network"
}

variable "service_account" {
  type        = string
  description = "The service account to use"
}
