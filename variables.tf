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

variable "domains" {
  type        = list(string)
  description = "The domains to serve"
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
