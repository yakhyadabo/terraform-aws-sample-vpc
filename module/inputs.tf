variable "environment" {
  type = string
  description = "Deployment Environment"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block of the vpc"
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
variable "region" {
  type = string
}
