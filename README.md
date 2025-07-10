# How to guide for setting up Azure SQL Server/Database

## Azure SQL Server

There are some resources which need to exist before trying to create your Azure SQL Server.

You will need to have the following:

- **Resource Group**: Have a unique resource group to use for your SQL Server and the resources within it.
- **Virtual Network Name**: The name of the VNet you plan on using for your SQL Server.
Make sure this is a part of your **Resource Group**.
- **Subnet Name**: The name of the subnet contained in your **Virtual Network**.
- **Azure AD Username**: This can be found at the top right of the [Azure Portal](https://portal.azure.com/?feature.msaljs=true#home), and is necessary for authentication into the SQL Server.

## Azure SQL Database

You will need to specify a set of values for your Azure SQL Database configuration.
These values will determine the capability of your database.

For ease of use, create an `override.tf` file to provide default values for your database.
It should look something like this:
```t
variable "login_username" {
  description = "Login username for Azure AD administrator"
  type        = string
  default     = "..." # Example value, replace with your actual username
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
  default     = "..."
}

variable "location" {
  description = "Location of the resources"
  type        = string
  default     = "..."
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "..."
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "..."
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "..."

}

default = {
    "db1" = {
      name                        = "test-sql-db"
      create_mode                 = "Default"
      collation                   = "SQL_Latin1_General_CP1_CI_AS"
      serverless                  = true
      max_size_gb                 = 10
      zone_redundant              = true
      sku_name                    = "GP_S_Gen5_2"
      min_capacity                = 0.5
      auto_pause_delay_in_minutes = -1

      short_term_retention_policy = {
        retention_days           = 7
        backup_interval_in_hours = 12
      }

      long_term_retention_policy = null
    }
  }
```
You can change these values depending on what you want your Azure SQL Database configuration to look like.

For additional information on what is needed for Azure SQL Databases, please refer to the [terraform documentation](https://registry.terraform.io/modules/Azure/avm-res-sql-server/azurerm/latest/submodules/database#input_name).
