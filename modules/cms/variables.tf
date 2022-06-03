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

variable "database_tier" {
  type        = string
  description = "The tier of the Cloud SQL instance"
  default     = "db-f1-micro"
}

variable "database_disk_type" {
  type        = string
  description = "The type of disk to use"
  default     = "PD_SSD"
}

variable "database_availability_type" {
  type        = string
  description = "The availability type of the Cloud SQL instance"
  default     = "ZONAL"
}

variable "database_version" {
  type        = string
  description = "The version of the Cloud SQL instance"
  default     = "POSTGRES_14"
}

variable "database_backup_start_time" {
  type        = string
  description = "The time of day to start the backup"
  default     = "01:00"
}

variable "database_backup_retention_days" {
  type        = number
  description = "The number of days to retain the backup"
  default     = 180
}

variable "service_account" {
  type        = string
  description = "The service account to use"
}