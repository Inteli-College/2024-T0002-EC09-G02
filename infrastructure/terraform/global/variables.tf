

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
  default     = "arn:aws:iam::058264141216:role/LabRole"
}

variable "dynamodb_arn" {
  type        = string
  description = "DynamoDB ARN"
  default     = "arn:aws:dynamodb:us-east-1::058264141216:table/*"
}

variable "bucket_state" {
  type        = string
  description = "S3 bucket for state"
  default     = "infrastructure-state-terraform20240322115712961400000002"
}

variable "kafka_bootstrap_servers" {
  type        = string
  description = "Kafka bootstrap servers"
  default     = "pkc-p11xm.us-east-1.aws.confluent.cloud:9092"
}

variable "kafka_username" {
  type        = string
  description = "Kafka username"
  default     = "R23TSC2632N5DZ6U"
}

variable "kafka_password" {
  type        = string
  description = "Kafka password"
  default     = "Vq7xv/7Hay9K64Jzq56ak7VsuP5WMpawYUm5GxV69O4YCKTx5s314LCf9Bd3QJP0"
}

variable "kafka_topic" {
  type        = string
  description = "Kafka topic"
  default     = "regions"
}
