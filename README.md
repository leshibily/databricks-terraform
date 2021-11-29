# Terraform Databricks E2 Workspaces

Terraform script to provision Databricks E2 Workspaces. Referenced from the official Databricks document: [Provision Databricks workspaces with Terraform (E2)
](https://docs.databricks.com/dev-tools/terraform/e2-workspace.html)

## Prerequisites
1. Install Terraform v1.0.10.
2. Create a terraform.tfvars file in the root directory. Example below.

## Variables

Below is an example `terraform.tfvars` file that you can use in your deployments:

```ini
aws_access_key = "AKICGY7QD2Z74EXAMPLE"
aws_secret_key = "fVSlK+df5htRFRqxP7AFGsLy6K19pEOa7example"

databricks_account_id = "<databricks_account_id>"
databricks_account_username = "<databricks_email_id>"
databricks_account_password = "<databricks_user_password>"

region = "ap-southeast-2"
prefix = "demo"

cidr_block = "10.4.0.0/16"
```

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
