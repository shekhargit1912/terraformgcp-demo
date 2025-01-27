variable "environment" {
  description = "Environment name (e.g., stage, prod)"
  type        = string
}

variable "region" {
  description = "The default region for resources"
  type        = string
}

variable "subnets" {
  description = "Map of subnet names to CIDR ranges"
  type        = map(string)
}