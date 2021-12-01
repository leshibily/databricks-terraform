variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "databricks_account_id" {}
variable "databricks_account_username" {}
variable "databricks_account_password" {}

variable "workspace_vpc_endpoint_id" {}
variable "relay_vpc_endpoint_id" {}

variable "tags" {
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnets' CIDR blocks."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnets' CIDR blocks."
}

variable "igw_id" {
  type = string
}

variable "region" {
  default = "ap-southeast-2"
}

variable "prefix" {
  type = string
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional resource tags. Do not include the Name key."
  default     = {}
}