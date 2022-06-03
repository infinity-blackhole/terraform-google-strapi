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

variable "service_account" {
  type        = string
  description = "The service account to use"
}
