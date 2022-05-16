variable "region" {
  default = "us-east-1"
}

variable "project" {
  type = object({
    name = string
    team      = string
    contact_email  = string
    environment = string
  })

  description = "Project details"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.2.0/24"]
}
