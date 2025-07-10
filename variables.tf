variable "login_username" {
  description = "Login username for Azure AD administrator"
  type        = string
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "name" {
  description = "Name of the SQL server"
  type        = string
}

variable "server_version" {
  description = "Version of the SQL server"
  type        = string
  default     = "12.0" # Default to SQL Server 2014
}

variable "databases" {
  description = "Map of databases to create"
  type = map(object({
    name                        = string
    create_mode                 = optional(string, "Default")
    collation                   = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    serverless                  = optional(bool, true)
    max_size_gb                 = number
    zone_redundant              = optional(bool, true)
    sku_name                    = optional(string, "GP_S_Gen5_2")
    min_capacity                = optional(number, 0.5)
    auto_pause_delay_in_minutes = optional(number, -1)

    short_term_retention_policy = object({
      retention_days           = optional(number, 7)
      backup_interval_in_hours = number
    })

    long_term_retention_policy = optional(object({
      weekly_retention  = string
      monthly_retention = string
      yearly_retention  = string
      week_of_year      = number
    }))
  }))
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
}
