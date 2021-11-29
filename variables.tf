variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "databricks_account_id" {}
variable "databricks_account_username" {}
variable "databricks_account_password" {}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  default = "ap-southeast-2"
}

variable "prefix" {
  type = string
}