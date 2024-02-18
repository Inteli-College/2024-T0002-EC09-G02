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
  type = string
  description = "Default availability zone"
  default = "us-east-1a" 
}