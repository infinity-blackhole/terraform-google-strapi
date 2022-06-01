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

variable "zone" {
  type        = string
  description = "The Google Cloud zone"
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

variable "max_instances" {
  type        = number
  description = "The maximum number of instances to run"
  default     = 1
}

variable "cpu" {
  type        = string
  description = "The amount of CPU to allocate to each instance"
  default     = "1000m"
}

variable "memory" {
  type        = string
  description = "The amount of memory to allocate to each instance"
  default     = "256Mi"
}

variable "cloudsql_tier" {
  type        = string
  description = "The tier of the Cloud SQL instance"
  default     = "db-f1-micro"
}

variable "cloudsql_availability_type" {
  type        = string
  description = "The availability type of the Cloud SQL instance"
  default     = "ZONAL"
}
