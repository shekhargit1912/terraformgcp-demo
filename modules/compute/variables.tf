variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_name" {
  description = "VPC network name"
  type        = string
}

variable "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  type        = map(string)
}

variable "instances" {
  description = "Map of instance configurations"
  type = map(object({
    machine_type = string
    zone         = string
    subnet_key   = string
  }))
}

variable "primary_zone" {
  description = "Primary zone for instance group"
  type        = string
}

variable "jumpbox_zone" {
  description = "Zone for jumpbox server"
  type        = string
}