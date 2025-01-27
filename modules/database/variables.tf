variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "Region for databases"
  type        = string
}

variable "vpc_id" {
  description = "VPC network ID"
  type        = string
}

variable "database_configs" {
  description = "Map of database configurations"
  type = map(object({
    tier = string
  }))
}