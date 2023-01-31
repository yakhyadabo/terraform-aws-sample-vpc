variable "region" {
  type = string
}

variable "project_name" {
  type = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = <<EOT
  The environment short name to use for the deployed resources.

  Options:
  - dev
  - uat
  - prd

  Default: dev
  EOT
  default     = "dev"

  validation {
    condition     = can(regex("^dev$|^uat$|^prd$", var.environment))
    error_message = "Err: invalid environment."
  }

  validation {
    condition     = length(var.environment) <= 3
    error_message = "Err: environment is too long."
  }
}

variable "subnet_tier" {
  type = string
  description = <<EOT
  The subnet in which to deploy our resources to.

  Options:
  - private
  - public
  - eks
  - dmz

  Default: private
  EOT
  default     = "private"

  validation {
    # condition     = can(regex("^private$|^public$|^eks$|^dmz$", var.subnet_zone))
    condition     = contains(["private","public", "eks", "dmz"],var.subnet_tier)
    error_message = "Err: subnet zone is not valid."
  }

  nullable = false
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block of the vpc"
/*  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "Must be a valid IPv4 CIDR block address."
  }*/
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
}

variable "dmz_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for the DMZ Subnet"
  default = []
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
}

variable "eks_cluster_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for EKS cluster Subnet"
}

variable "availability_zones" {
  type        = list(any)
  description = "AZ in which all the resources will be deployed"
}