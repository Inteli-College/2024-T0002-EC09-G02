

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["192.168.0.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["192.168.1.0/24"]
}

variable "default_availability_zone" {
  type        = string
  description = "Default availability zone"
  default     = "us-east-1a"
}

variable "lab_role" {
  type        = string
  description = "Lab role"
  default     = "arn:aws:iam::730335212171:role/LabRole"
}

variable "dynamodb_arn" {
  type        = string
  description = "DynamoDB ARN"
  default     = "arn:aws:dynamodb:us-east-1::730335212171:table/*"
}

variable "bucket_state" {
  type        = string
  description = "S3 bucket for state"
  default     = "infrastructure-state-terraform20240325111449711200000002"
}
