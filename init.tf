resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "${var.prefix}${random_string.naming.result}"
  tags = merge(
    var.additional_tags,
    {
      provisioned_by = "Terraform"
    }
  )
}