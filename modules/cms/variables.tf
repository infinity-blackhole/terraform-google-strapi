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
}

variable "image" {
  type        = string
  description = "The Docker image to use"
}

variable "cpu" {
  type        = string
  description = "The amount of CPU to allocate to the container"
}

variable "memory" {
  type        = string
  description = "The amount of memory to allocate to the container"
}

variable "max_instances" {
  type        = number
  description = "The maximum number of instances to run"
}

variable "client_name" {
  type        = string
  description = "The name of the client"
}

variable "client_version" {
  type        = string
  description = "The version of the client"
}

variable "database_tier" {
  type        = string
  description = "The tier of the Cloud SQL instance"
}

variable "database_disk_type" {
  type        = string
  description = "The type of disk to use"
}

variable "database_availability_type" {
  type        = string
  description = "The availability type of the Cloud SQL instance"
}

variable "database_version" {
  type        = string
  description = "The version of the Cloud SQL instance"
}

variable "database_backup_start_time" {
  type        = string
  description = "The time of day to start the backup"
}

variable "database_backup_retention_days" {
  type        = number
  description = "The number of days to retain the backup"
}

variable "service_account" {
  type        = string
  description = "The service account to use"
}
