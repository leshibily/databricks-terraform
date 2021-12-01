# Terraform Databricks E2 Workspaces

Terraform script to provision Databricks E2 Workspaces. Referenced from the official Databricks document: [Provision Databricks workspaces with Terraform (E2)
](https://docs.databricks.com/dev-tools/terraform/e2-workspace.html)

## Prerequisites
1. Install Terraform v1.0.10.
2. Create a terraform.tfvars file in the root directory. Example below.

## Variables

Below is an example `terraform.tfvars` file that you can use in your deployments:

```ini
aws_access_key = "AKSLPA3QD2Z74EXAMPLE"
aws_secret_key = "sDXlK+uifTbRFRqxP7AFGsLy6K19pEOa7EXAMPLE"

databricks_account_id = "<databricks_account_id>"
databricks_account_username = "<databricks_email_id>"
databricks_account_password = "<databricks_user_password>"

vpc_id = "vpc-01ef400f0fexample"
igw_id = "igw-0c8e654e88example"

# add private and public subnet cidrs based on your vpc cidr range. The below is for the VPC CIDR: 10.79.0.0/22
private_subnet_cidrs = [
  "10.79.2.0/25",
  "10.79.2.128/25"
]
public_subnet_cidrs = [
  "10.79.3.0/25",
  "10.79.3.128/25"
]
workspace_vpc_endpoint_id = "vpce-0dea56afdaexample"
relay_vpc_endpoint_id     = "vpce-0701a663d3example"

region = "ap-southeast-2"
prefix = "databricks"
```

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
