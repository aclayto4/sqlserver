data "azurerm_client_config" "current" {}

data "azurerm_subnet" "sql_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

module "naming" {
  source  = "Azure/naming/azurerm"
}

module "sql" {
  source = "../../"
  ## source = "github.com/networkrail-azure/azure-sql?ref=v4.0.0"

  name                   = "${module.naming.sql_server.name}-${var.name}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  server_version         = var.server_version
  databases              = local.databases
  virtual_network_name   = var.virtual_network_name
  subnet_name            = var.subnet_name
  login_username         = var.login_username
  private_endpoint_name  = "${module.naming.private_endpoint.name}-${var.private_endpoint_name}"
}

locals {
  databases = {
    example_database = {
      name                             = var.database_name
      create_mode                      = "Default"
      license_type                     = var.serverless ? null : "LicenseIncluded"
      collation                        = "SQL_Latin1_General_CP1_CI_AS"
      max_size_gb                      = 50
      zone_redundant                   = var.zone_redundant
      sku_name                         = var.sku_name
      min_capacity                     = 0.5
      auto_pause_delay_in_minutes      = -1

      short_term_retention_policy = {
        retention_days           = 7
        backup_interval_in_hours = 12
      }

      tags = {
          environment = "example"
          team        = "example-team"
        }
    }
  }
}